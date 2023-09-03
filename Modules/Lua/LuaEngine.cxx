module;

#define SOL_LUAJIT 1
#include <sol/sol.hpp>

#include <ctime>

module LuaEngine;
import Logger;
import Present;

import <Windows.h>;
import <span>;

using namespace ALIM;

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
            Result << "[[table: " << Table.pointer() << "]]: {";
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
            ss << "[[function: " << Value.as<sol::function>().pointer() << "]]";
            return ss.str();
        }

        case sol::type::poly:
            return "<poly>";

        default:
            return "<unprintable type>";
    }
}

void L_EnableCursor(const bool Enabled) {
    Present::CursorEnabled = Enabled;

    if (Enabled) {
        ClipCursor(NULL);
        ShowCursor(true);
    } else {
        RECT WindowRect;

        GetClientRect(Present::WindowHandle, &WindowRect);
        MapWindowPoints(Present::WindowHandle, NULL, reinterpret_cast<LPPOINT>(&WindowRect), 2);
        ClipCursor(&WindowRect);
        ShowCursor(false);
    }
}

void L_Print(sol::variadic_args Args) {
    std::string Output = "";
    for (const auto& Arg : Args) {
        Output += LuaToString(static_cast<sol::object>(Arg));
        Output += "\t";
    }

    ALIM_CORE_INFO("[Lua] {}", Output);
}

void LuaEngine::Initialize() {
    lua = std::make_unique<sol::state>();
    lua->open_libraries();

    sol::table globals = lua->get<sol::table>("_G");
    globals.set("ALIM_EnableCursor", L_EnableCursor);
    globals.set("print", L_Print);

    lua->script("package.path = package.path .. ';ALIM/Lua' ffi = require('ffi') imgui = require('ALIM/Lua/ImGui')");
    lua->safe_script_file("ALIM/Lua/Main.lua", [](lua_State*, sol::protected_function_result pfr) {
        sol::error err = pfr;
        ALIM_CORE_ERROR("Lua Result: {}", err.what());
        
        return pfr;
    });
}

void LuaEngine::Render() {
    sol::function renderFn = lua->get<sol::function>("onRender");
    if (!renderFn)
        return;

    sol::safe_function_result res = renderFn.call();
    if (res.status() != sol::call_status::ok) {
        sol::error err = res;
        ALIM_CORE_ERROR("Failed calling render: {}", err.what());
    }
}

void LuaEngine::SendKey(const std::size_t VirtualKey, const bool KeyDown) {
    sol::function keyEventFn = lua->get<sol::function>("onKeyEvent");
    if (!keyEventFn)
        return;

    sol::safe_function_result res = keyEventFn.call(VirtualKey, KeyDown);
    if (res.status() != sol::call_status::ok) {
        sol::error err = res;
        ALIM_CORE_ERROR("Failed sending key event: {}", err.what());
    }
}