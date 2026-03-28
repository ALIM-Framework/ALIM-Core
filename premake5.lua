require("library_helpers")

VCPKG_ROOT = os.getenv("VCPKG_ROOT")
USE_DUMPER = false

workspace "ALIM-Core"
    configurations { "Debug", "Release" }

    filter "configurations:*"
        architecture "x86"

    cppdialect "C++latest"
    staticruntime "on"
    language "C++"
	characterset "Unicode"

project "ALIM-Core"
    kind "SharedLib"
    targetdir "Build/%{cfg.buildcfg}"
    objdir "Build/Intermediate/%{cfg.buildcfg}"
    location "Solution"

    enablemodules("On")
    buildstlmodules("On")
    scanformoduledependencies("On")

    filter "system:windows"
        buildoptions { "/utf-8" }

    buildoptions "/dxifcInlineFunctions-" --[[
        fixes the following:
        'inline' function definition for 'ULONGLONG Int64ShllMod32(ULONGLONG,DWORD)' could not be written to module due to unrecognized expression or statement at 'C:\Program Files (x86)\ Windows Kits\10\Include\10.0.22621.0\um\winnt.h(1010,5)'
        'inline' function definition for 'LONGLONG Int64ShraMod32(LONGLONG,DWORD)' could not be written to module due to unrecognized expression or statement at 'C:\Program Files (x86)\Windows Kits\10\Include\10.0.22621.0\um\winnt.h(1026,5)'

        etc...
        Version MSVC 17.5+

        Also requires `Onecore.lib`

		Edit: The new version also seems to fix having to include ctime whenever I use spdlog
    --]]

    files {
        "Code/Source/**.cpp", "Code/Source/**.cxx", "Code/Source/**.ixx", "Code/Interfaces/**.ixx"
    }

    link_library("imgui")
    link_library("luajit")
    link_library("sol")
    link_library("spdlog")
    link_library("minhook")

    includedirs {
        "Code/Include"
    }

    links { "volatileaccessu", "lua51" }

    filter "configurations:Debug"
        defines { "DEBUG", "_ITERATOR_DEBUG_LEVEL=2", "SPDLOG_ACTIVE_LEVEL=SPDLOG_LEVEL_TRACE" }
        links { "fmtd", "imm32", "Onecore" }

        symbols "On"
        runtime "Debug"

    filter "configurations:Release"
        defines { "NDEBUG" }
        links { "spdlog", "fmt" }

        symbols "On"
        runtime "Release"