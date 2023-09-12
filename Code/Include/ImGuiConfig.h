#ifndef IMGUI_CONFIG_H
#define IMGUI_CONFIG_H

#include <limits>

import Logger;
#define IM_ASSERT(expression) (void)( \
    (!!(expression)) ||       \
    (ALIM::Logger::Log(       \
        ELogLevel::Error,     \
        ELoggerType::LT_CORE, \
        #expression),         \
        0                     \
    )                         \
)

#endif