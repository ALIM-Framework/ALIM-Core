module;

#include <time.h>
#include <stdio.h>

#include <spdlog/spdlog.h>
#include <spdlog/sinks/stdout_color_sinks.h>
#include <spdlog/sinks/basic_file_sink.h>

module Logger;
import <string_view>;
import <memory>;
import <vector>;

using namespace ALIM;

std::shared_ptr<spdlog::logger> Log::_Logger;

void Log::Initialize() {
    std::shared_ptr<spdlog::sinks::stdout_color_sink_mt> ConsoleSink = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();
    ConsoleSink->set_level(spdlog::level::trace);
    ConsoleSink->set_pattern("[%H:%M:%S] [%^%n%$] [%^%l%$] [%s:%#]: %v");

    auto FileSink = std::make_shared<spdlog::sinks::basic_file_sink_mt>("ALIM-Core.log", true);
    FileSink->set_level(spdlog::level::trace);
    FileSink->set_pattern("[%H:%M:%S] [%n] [%^%l%$] [%s:%#]: %v");

    std::vector<spdlog::sink_ptr> Sinks{ConsoleSink, FileSink};

    _Logger = std::make_shared<spdlog::logger>("ALIM-Core", Sinks.begin(), Sinks.end());

    _Logger->set_level(spdlog::level::trace);
    _Logger->flush_on(spdlog::level::trace);
}