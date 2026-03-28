module;

#define SOL_LUAJIT 1
#include <sol/sol.hpp>
#include <spdlog/spdlog.h>

#include <imgui.h>

module LuaEngine;
import Logger;
import Present;
import Window;
import Offsets;

import <Windows.h>;
import <string_view>;

using namespace ALIM;

// Helper Functions
//------------------------------------------------------------------------
// https://github.com/BeamMP/BeamMP-Server/blob/2c29a195f9f58f5512cd74469082e542aff49a29/src/LuaAPI.cpp#L12
std::string LuaToString(const sol::object Value, size_t Indent = 1, bool QuoteStrings = false) {
    if (Indent > 80)
        return "[[Possible Recursion, refusing to keep printing]]";

    switch (Value.get_type()) {
        case sol::type::userdata: {
            std::stringstream ss;
            ss << "[[UserData: " << Value.as<sol::userdata>().pointer() << "]]";
            return ss.str();
        }

        case sol::type::thread: {
            std::stringstream ss;
            ss << "[[Thread: " << Value.as<sol::thread>().pointer() << "]] {"
            << "\n";
            for (size_t i = 0; i < Indent; ++i) {
                ss << "\t";
            }
            ss << "status: " << std::to_string(int(Value.as<sol::thread>().status())) << "\n}";
            return ss.str();
        }

        case sol::type::lightuserdata: {
            std::stringstream ss;
            ss << "[[LightUserData: " << Value.as<sol::lightuserdata>().pointer() << "]]";
            return ss.str();
        }

        case sol::type::string: {
            if (QuoteStrings) {
                return "\"" + Value.as<std::string>() + "\"";
            } else {
                return Value.as<std::string>();
            }
        }

        case sol::type::number: {
            std::stringstream ss;
            ss << Value.as<float>();
            return ss.str();
        }

        case sol::type::lua_nil:

            [[fallthrough]];
        case sol::type::none:

            return "<nil>";
        case sol::type::boolean:
            return Value.as<bool>() ? "true" : "false";

        case sol::type::table: {
            std::stringstream Result;
            auto Table = Value.as<sol::table>();
            Result << "[[Table: " << Table.pointer() << "]]: {";
            if (!Table.empty()) {
                for (const auto& Entry : Table) {
                    Result << "\n";
                    for (size_t i = 0; i < Indent; ++i)
                        Result << "\t";

                    Result << LuaToString(Entry.first, Indent + 1) << ": " << LuaToString(Entry.second, Indent + 1, true) << ",";
                }

                Result << "\n";
            }

            for (size_t i = 0; i < Indent - 1; ++i)
                Result << "\t";

            Result << "}";
            return Result.str();
        }

        case sol::type::function: {
            std::stringstream ss;
            ss << "[[Function: " << Value.as<sol::function>().pointer() << "]]";
            return ss.str();
        }

        case sol::type::poly:
            return "<Poly>";

        default:
            return "<Unprintable Type>";
    }
}

template <typename... Ret, typename... Args>
decltype(auto) LuaEngine::CallEvent(std::string_view name, Args&&... Arguments) {
    sol::function Function = m_LuaState->get<sol::function>(name);
    if (!Function)
        return std::make_tuple(std::optional<Ret>()...);

    sol::protected_function_result Result = Function.call(std::forward<Args>(Arguments)...);
    if (!Result.valid()) {
        sol::error err = Result;
        ALIM_CORE_ERROR("Failed calling \"{}\": {}", name, err.what());
        return std::make_tuple(std::optional<Ret>()...);
    }

    return Result.get<std::tuple<Ret...>>();
}

// Destructor
//------------------------------------------------------------------------
LuaEngine::LuaEngine() : m_bInitialized(false) {}

LuaEngine::~LuaEngine() {
    ALIM_CORE_DEBUG("LuaEngine::~LuaEngine called");
    this->CallEvent("onExit");
}

// Lua Functions
//------------------------------------------------------------------------
namespace Lua {
    namespace Function {
        void Log(spdlog::level::level_enum level, sol::variadic_args& Args) {
            std::string Output = "";
            for (const auto& Arg : Args) {
                Output += LuaToString(static_cast<sol::object>(Arg));
                Output += "\t";
            }

            std::string_view format = "{}";

            switch (level) {
                case spdlog::level::trace: // spdlog::level::xxx Deprecated
                    ALIM_LUA_VERBOSE(format, Output);
                    break;
                case spdlog::level::debug:
                    ALIM_LUA_DEBUG(format, Output);
                    break;
                case spdlog::level::info:
                    ALIM_LUA_INFO(format, Output);
                    break;
                case spdlog::level::warn:
                    ALIM_LUA_WARN(format, Output);
                    break;
                case spdlog::level::err:
                    ALIM_LUA_ERROR(format, Output);
                    break;
                default:
                    ALIM_CORE_WARN("[Lua] Unknown log level, defaulting to info");
                    ALIM_CORE_WARN(format, Output);
                    break;
            }
        }

        void Print(sol::state_view lua, sol::variadic_args args) noexcept {
            Log(spdlog::level::info, args);
        }
    }

    using tTriggerSoundEvent = std::add_pointer_t<int __stdcall(const char* Source, int a2)>;

    class ALIM {
    public:
        void EnableCursor(const bool enabled) {
            Window::EnableCursor(enabled);
        }

        void TriggerSoundEvent(const char* Name, int a2) {
            tTriggerSoundEvent TriggerSoundEvent = reinterpret_cast<tTriggerSoundEvent>(Offsets::UI::AUDIO_CALLBACK::TriggerSoundEvent);
            TriggerSoundEvent(Name, a2);
        }
    
        void Trace(sol::variadic_args args) noexcept { Lua::Function::Log(spdlog::level::trace, args); }
        void Debug(sol::variadic_args args) noexcept { Lua::Function::Log(spdlog::level::debug, args); }
        void  Info(sol::variadic_args args) noexcept { Lua::Function::Log(spdlog::level::info, args); }
        void  Warn(sol::variadic_args args) noexcept { Lua::Function::Log(spdlog::level::warn, args); }
        void Error(sol::variadic_args args) noexcept { Lua::Function::Log(spdlog::level::err, args); }
    };
}

void LuaEngine::Initialize() noexcept {
    if (Window::CursorEnabled)
        Window::EnableCursor(false); // If you reload Lua whilst the cursor is enabled, it will break it
                                     // Mouse will show in-game with first person camera

    ALIM_CORE_DEBUG("Creating lua state...");
    m_LuaState = std::make_unique<sol::state>();
    m_LuaState->open_libraries();
    m_LuaState->set_exception_handler([](lua_State* L, sol::optional<const std::exception&> MaybeException, sol::string_view Description) -> int {
        if (MaybeException) {
            const std::exception& Exception = *MaybeException;
            ALIM_CORE_FATAL("Exception: {}", Exception.what());
        } else {
            ALIM_CORE_FATAL("Exception: {}", Description.data());
        }

        return sol::stack::push(L, Description);
    });

    sol::table globals = m_LuaState->get<sol::table>("_G");
    sol::usertype<Lua::ALIM> alim = m_LuaState->new_usertype<Lua::ALIM>(
        "alim",
        "enableCursor", &Lua::ALIM::EnableCursor,
        "triggerSoundEvent", &Lua::ALIM::TriggerSoundEvent,

        "trace", &Lua::ALIM::Trace,
        "debug", &Lua::ALIM::Debug,
        "info", &Lua::ALIM::Info,
        "warn", &Lua::ALIM::Warn,
        "error", &Lua::ALIM::Error
    );

    globals.set("print", Lua::Function::Print);
    globals.set("alim", alim.get<sol::function>("new").call());

    if (m_LuaState->safe_script("ffi = require('ffi'); imgui = require('DATA/ALIM/LUA/imgui/imgui')", [this](lua_State*, sol::protected_function_result pfr) {
        sol::error err = pfr;
        ALIM_CORE_ERROR("Failed setting up Lua: {}", err.what());
        m_bInitialized = true;
        
        return pfr;
    }).status() != sol::call_status::ok) {
        return;
    };

    if (m_LuaState->safe_script_file("DATA/ALIM/LUA/main.lua", [this](lua_State*, sol::protected_function_result pfr) {
        sol::error err = pfr;
        ALIM_CORE_ERROR("Failed loading \"DATA/ALIM/LUA/main.lua\": {}", err.what());
        
        return pfr;
    }).status() != sol::call_status::ok) {
        return;
    };

    m_bInitialized = true;

    CallEvent("onInitialize");
}

void LuaEngine::OnResize(const uint32_t width, const uint32_t height) noexcept {
    if (!m_bInitialized) return;
    CallEvent("onResize", width, height);
}

void LuaEngine::Render() noexcept {
    if (!m_bInitialized) return;
    CallEvent("onRender");
}

void LuaEngine::SendKey(const std::size_t vkey, const bool down) noexcept {
    if (!m_bInitialized) return;
    CallEvent("onKeyEvent", vkey, down);
}

void LuaEngine::AddLog(std::string_view Time, std::string_view LT, std::string_view Level, std::string_view Message) {
    if (!m_bInitialized) return;
    CallEvent("_console_add_log", Time, LT, Level, Message);
}