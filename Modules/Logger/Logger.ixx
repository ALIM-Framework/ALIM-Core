module;

#define SPDLOG_ACTIVE_LEVEL SPDLOG_LEVEL_TRACE
#include <spdlog/spdlog.h>
#include <ctime>
#include <fmt/format.h>

export module Logger;
import <string_view>;
import <source_location>;
import <memory>;

export namespace ALIM {
    export class Log {
    public:
        static void Initialize();
        static std::shared_ptr<spdlog::logger> GetInstance() { return _Logger; }

    private:
        static std::shared_ptr<spdlog::logger> _Logger;
    };
}

// https://github.com/gabime/spdlog/issues/1959
// Had to use that because the trace level doesn't work with modules? Not sure, I tried everything but nothing worked.
using source_location = std::source_location;
[[nodiscard]] constexpr auto get_log_source_location(const source_location &location) {
    return spdlog::source_loc {
        location.file_name(),
        static_cast<std::int32_t>(location.line()),
        location.function_name()
    };
}

struct format_with_location {
    std::string_view Value;
    spdlog::source_loc Location;

    template<typename S>
    format_with_location(const S& s, const source_location& location = source_location::current()) : Value(s), Location(get_log_source_location(location)) {}
};

export {
    template<typename... Args>
    inline void ALIM_CORE_TRACE(const format_with_location& Format, Args&&... Arguments) {
        ALIM::Log::GetInstance()->log(Format.Location, spdlog::level::trace, fmt::runtime(Format.Value), std::forward<Args>(Arguments)...);
    }

    template<typename... Args>
    inline void ALIM_CORE_DEBUG(const format_with_location& Format, Args&&... Arguments) {
        ALIM::Log::GetInstance()->log(Format.Location, spdlog::level::debug, fmt::runtime(Format.Value), std::forward<Args>(Arguments)...);
    }

    template<typename... Args>
    inline void ALIM_CORE_INFO(const format_with_location& Format, Args&&... Arguments) {
        ALIM::Log::GetInstance()->log(Format.Location, spdlog::level::info, fmt::runtime(Format.Value), std::forward<Args>(Arguments)...);
    }

    template<typename... Args>
    inline void ALIM_CORE_WARN(const format_with_location& Format, Args&&... Arguments) {
        ALIM::Log::GetInstance()->log(Format.Location, spdlog::level::warn, fmt::runtime(Format.Value), std::forward<Args>(Arguments)...);
    }

    template<typename... Args>
    inline void ALIM_CORE_ERROR(const format_with_location& Format, Args&&... Arguments) {
        ALIM::Log::GetInstance()->log(Format.Location, spdlog::level::err, fmt::runtime(Format.Value), std::forward<Args>(Arguments)...);
    }
}