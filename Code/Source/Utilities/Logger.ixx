module;

#include <ctime>
#include <chrono>
#include <fmt/format.h>

export module Logger;
import Memory;
import LuaEngine;

import <Windows.h>;
import <cstdarg>;
import <string_view>;
import <unordered_map>;
import <filesystem>;
import <iostream>;
import <fstream>;
import <string>;
import <queue>;
import <mutex>;
import <memory>;
import <sstream>;

// Enums
//------------------------------------------------------------------------
export enum class ELoggerType : std::uint8_t {
    LT_CORE = 0,
    LT_AI,
    LT_LUA
};

export enum class ELogLevel : std::uint8_t {
    Verbose = 0,
    Debug,
    Info,
    Warning,
    Error,
    Fatal
};

namespace ALIM::Logger {
    // Structures
    //------------------------------------------------------------------------
    struct MessageEvent {
        std::string ConsoleData;
        std::string FileData;
        ELoggerType Type;
    };

    namespace fs = std::filesystem;

    std::condition_variable WaitCondition;
    std::queue<MessageEvent> LogQueue;
    std::mutex LogMutex;
    bool ShouldQuit;

    std::unordered_map<std::string, std::ofstream*> LogFiles;

    std::ofstream CoreFile;
    std::ofstream AIFile;
    std::ofstream LuaFile;

    export inline void Initialize() {
        const auto Path = fs::current_path();
        fs::path LogPath = Path / "DATA" / "ALIM" / "LOGS";
        if (!fs::exists(LogPath))
            fs::create_directories(LogPath);

        CoreFile.open((LogPath / "Core.log").string(), std::ios::out | std::ios::trunc);
        AIFile.open  ((LogPath / "AI.log"  ).string(), std::ios::out | std::ios::trunc);
        LuaFile.open ((LogPath / "Lua.log" ).string(), std::ios::out | std::ios::trunc);

        // Create Thread
        std::thread LoggingThread([&] {
            while (!ShouldQuit) {
                MessageEvent Message;

                { // Wait Condition
                    std::unique_lock<std::mutex> Lock(LogMutex);
                    WaitCondition.wait(Lock, [] {
                        return ShouldQuit || !LogQueue.empty();
                    });

                    if (ShouldQuit)
                        break;

                    Message = LogQueue.front();
                    LogQueue.pop();
                }

                // Write to Console
                std::cout << Message.ConsoleData;

                { // Write to File
                    // TODO: Rotating Files + 1MB Limit

                    std::ofstream* OutFile = nullptr;
                    switch (Message.Type) {
                        case ELoggerType::LT_CORE:
                            OutFile = &CoreFile;
                            break;
                        case ELoggerType::LT_LUA:
                            OutFile = &LuaFile;
                            break;
                        case ELoggerType::LT_AI:
                            OutFile = &AIFile;
                            break;
                    }

                    if (OutFile) {
                        *OutFile << Message.FileData;
                        OutFile->flush();
                    }
                }
            }

            CoreFile.close();
            LuaFile.close();
            AIFile.close();
        }); LoggingThread.detach();
    }

    export inline void Shutdown() {
        ShouldQuit = true;
    }

    inline std::string GetTimeFormatted() {
        using namespace std::chrono;
        const system_clock::time_point Now = system_clock::now();
        const std::time_t Time = system_clock::to_time_t(Now);

        std::tm TimeInfo = {};
        localtime_s(&TimeInfo, &Time);

        char TimeString[9];
        std::strftime(TimeString, sizeof(TimeString), "%H:%M:%S", &TimeInfo);

        return std::string(TimeString);
    }

    constexpr inline std::string_view LogLevelToString(const ELogLevel Level) {
        switch (Level) {
            case ELogLevel::Verbose:
                return "Verbose";
            case ELogLevel::Debug:
                return "Debug";
            case ELogLevel::Info:
                return "Info";
            case ELogLevel::Warning:
                return "Warning";
            case ELogLevel::Error:
                return "Error";
            case ELogLevel::Fatal:
                return "Fatal";
            default:
                return "Info";
        }
    }

    constexpr inline std::string_view LogTypeToString(const ELoggerType Type) {
        switch (Type) {
            case ELoggerType::LT_CORE:
                return "Core";
            case ELoggerType::LT_AI:
                return "AI";
            case ELoggerType::LT_LUA:
                return "Lua";
            default:
                return "Core";
        }
    }

    constexpr std::string_view GetColorForType(ELoggerType Type) {
        if (Type == ELoggerType::LT_CORE)
            return "\033[1;33m"; // Orange
        if (Type == ELoggerType::LT_AI)
            return "\033[0;91m"; // Light Red
        if (Type == ELoggerType::LT_LUA)
            return "\033[0;94m"; // Light Blue
        return "";
    }

    export template<typename... Args>
    constexpr inline void Log(const ELogLevel Level,
                    const ELoggerType Type,
                    const std::string_view Format,
                    Args&&... Arguments)
    {
        std::string_view TypeColour = GetColorForType(Type);

        const std::string Time = GetTimeFormatted();
        const std::string_view LogTypeString = LogTypeToString(Type);
        const std::string_view LogLevelString = LogLevelToString(Level);

        auto FormattedString = std::vformat(Format, std::make_format_args(Arguments...));
        std::stringstream SConsoleBuffer;
        SConsoleBuffer << "[" << Time << "] " // Time
                << "[" << TypeColour << std::setw(4) << LogTypeString << "\033[0m] " // Log Type & Colour
                << "[" << std::setw(5) << LogLevelString << "] "
                << FormattedString << "\n";

        std::stringstream SFileBuffer;
        SFileBuffer << "[" << Time << "] " // Time
                << "[" << std::setw(4) << LogTypeString << "] " // Log Type & Colour
                << "[" << std::setw(5) << LogLevelString << "] "
                << FormattedString << "\n";

        {
            std::lock_guard<std::mutex> LockFile(LogMutex);
            LogQueue.push({
                SConsoleBuffer.str(),
                SFileBuffer.str(),
                Type
            });
        }

        WaitCondition.notify_one();
    }

    // Hook
    //------------------------------------------------------------------------
    using tSprintf = std::add_pointer_t<int __cdecl(char* Buffer, const char* Format, ...)>;
    tSprintf oSprintf = nullptr;

    int __cdecl hPrintf(char* Format, ...) {
        va_list Args;
        va_start(Args, Format);

        va_list ArgsCopy;
        va_copy(ArgsCopy, Args);
        int Size = vsnprintf(nullptr, 0, Format, ArgsCopy);
        va_end(ArgsCopy);
    
        if (Size >= 0) {
            // We do `Size - 1` to remove the newline
            std::string FormattedString(Size - 1, '\0');
    
            // Format the string
            int Result = vsnprintf(&FormattedString[0], Size - 1, Format, Args);
            if (Result >= 0)
                Logger::Log(ELogLevel::Info, ELoggerType::LT_AI, FormattedString);
        } else {
            Logger::Log(ELogLevel::Warning, ELoggerType::LT_AI, "Invalid message");
        }
    
        va_end(Args);
        return 0;
    }

    export inline void Hook() {
        // Printf
        //------------------------------------------------------------------------
        auto PrintfSig = Memory::Signature("\xE8\x00\x00\x00\x00\x8B\x93\x00\x00\x00\x00\x83\xC4\x0C", "x????xx????xxx", true);

//         auto Result = Memory::InstallHook(PrintfSig, &hPrintf);
//         if (Result.Error != MH_OK) {
//             Logger::Log(ELogLevel::Error, ELoggerType::LT_CORE, "Failed hooking \"printf\": {}", MH_StatusToString(static_cast<MH_STATUS>(Result.Error)));
//         }
    }
}

#define ALIM_DEFINE_LOG_FUNC(name, level, loggerType)                                                                 \
    export template<typename... Args>                                                                                 \
    constexpr inline void ALIM_##name(std::string_view Format, Args&&... Arguments) {                                 \
        ALIM::Logger::Log(ELogLevel::level, ELoggerType::loggerType, Format, std::forward<Args>(Arguments)...); \
    }

ALIM_DEFINE_LOG_FUNC(CORE_VERBOSE, Verbose, LT_CORE)
ALIM_DEFINE_LOG_FUNC(CORE_DEBUG,   Debug,   LT_CORE)
ALIM_DEFINE_LOG_FUNC(CORE_INFO,    Info,    LT_CORE)
ALIM_DEFINE_LOG_FUNC(CORE_WARN,    Warning, LT_CORE)
ALIM_DEFINE_LOG_FUNC(CORE_ERROR,   Error,   LT_CORE)
ALIM_DEFINE_LOG_FUNC(CORE_FATAL,   Fatal,   LT_CORE)

ALIM_DEFINE_LOG_FUNC(LUA_VERBOSE,  Verbose,  LT_LUA)
ALIM_DEFINE_LOG_FUNC(LUA_DEBUG,    Debug,    LT_LUA)
ALIM_DEFINE_LOG_FUNC(LUA_INFO,     Info,     LT_LUA)
ALIM_DEFINE_LOG_FUNC(LUA_WARN,     Warning,  LT_LUA)
ALIM_DEFINE_LOG_FUNC(LUA_ERROR,    Error,    LT_LUA)
ALIM_DEFINE_LOG_FUNC(LUA_FATAL,    Fatal,    LT_LUA)

ALIM_DEFINE_LOG_FUNC(AI_VERBOSE,   Verbose,  LT_AI)
ALIM_DEFINE_LOG_FUNC(AI_DEBUG,     Debug,    LT_AI)
ALIM_DEFINE_LOG_FUNC(AI_INFO,      Info,     LT_AI)
ALIM_DEFINE_LOG_FUNC(AI_WARN,      Warning,  LT_AI)
ALIM_DEFINE_LOG_FUNC(AI_ERROR,     Error,    LT_AI)
ALIM_DEFINE_LOG_FUNC(AI_FATAL,     Fatal,    LT_AI)