VCPKG_ROOT = os.getenv("VCPKG_ROOT")
USE_DUMPER = false

workspace "ALIM-Core"
    configurations { "Debug", "Release" }

    filter "configurations:*"
        architecture "x86"

    cppdialect "C++latest"
    staticruntime "on"
    language "C++"

project "ALIM-Core"
    kind "SharedLib"
    targetdir "Build/%{cfg.buildcfg}"
    objdir "Build/Intermediate/%{cfg.buildcfg}"
	location "Solution"

    buildoptions "/dxifcInlineFunctions-" --[[
        fixes the following:
        'inline' function definition for 'ULONGLONG Int64ShllMod32(ULONGLONG,DWORD)' could not be written to module due to unrecognized expression or statement at 'C:\Program Files (x86)\ Windows Kits\10\Include\10.0.22621.0\um\winnt.h(1010,5)'
        'inline' function definition for 'LONGLONG Int64ShraMod32(LONGLONG,DWORD)' could not be written to module due to unrecognized expression or statement at 'C:\Program Files (x86)\Windows Kits\10\Include\10.0.22621.0\um\winnt.h(1026,5)'

        etc...
        Version MSVC 17.5+

        Also requires `Onecore.lib`

		Edit: The new version also seems to fix having to include ctime whenever I use spdlog
    --]]

    -- TODO: Improve this for the Dumper
    files {
		"Code/Source/**.cpp", "Code/Source/**.cxx", "Code/Interfaces/**.ixx",
        "Submodules/imgui/imgui.cpp",
        "Submodules/imgui/imgui_draw.cpp",
        "Submodules/imgui/imgui_demo.cpp",
        "Submodules/imgui/imgui_widgets.cpp",
        "Submodules/imgui/imgui_tables.cpp",
        "Submodules/imgui/backends/imgui_impl_win32.cpp",
        "Submodules/imgui/backends/imgui_impl_dx11.cpp"
	}

    includedirs {
        VCPKG_ROOT .. "/installed/x86-windows-static/include", -- TODO: Remove and replace with each one, that way there's no issues in the future (like having lua and luajit installed)
        VCPKG_ROOT .. "/installed/x86-windows-static/include/luajit",
        "Submodules/Sol2/include",
		"Submodules/imgui",
		"Submodules/imgui/backends",
        "Code/Include"
    }

    filter "configurations:Debug"
        defines { "DEBUG", "_ITERATOR_DEBUG_LEVEL=2", "SPDLOG_ACTIVE_LEVEL=SPDLOG_LEVEL_TRACE", "IMGUI_DISABLE_OBSOLETE_FUNCTIONS=1", "SOL_LUAJIT=1", "IMGUI_USER_CONFIG=\"ImGuiConfig.h\"" }
        libdirs { VCPKG_ROOT .. "/installed/x86-windows-static/debug/lib", "Submodules/cimgui/cmake_build/build32/Debug" }
        links { "minhook.x32d", "fmtd", "lua51", "imm32", "Onecore" }

        symbols "On"
        runtime "Debug"

    filter "configurations:Release"
        defines { "NDEBUG", "IMGUI_DISABLE_OBSOLETE_FUNCTIONS=1", "SOL_LUAJIT=1" }
        libdirs { "$(VCPKG_ROOT)/installed/x86-windows-static/lib" }
        links { "minhook.x32", "spdlog", "fmt", "lua51" }

        symbols "On"
        runtime "Release"




require('vstudio')

local p = premake
local m = p.vstudio.vc2010

m.elements.clCompile = function(cfg)
	local calls = {
        function(cfg) m.element("ScanSourceForModuleDependencies", nil, "true") end,
        function(cfg) m.element("EnableModules", nil, "true") end,
        function(cfg) m.element("BuildStlModules", nil, "true") end,

		m.precompiledHeader,
		m.warningLevel,
		m.treatWarningAsError,
		m.disableSpecificWarnings,
		m.treatSpecificWarningsAsErrors,
		m.basicRuntimeChecks,
		m.clCompilePreprocessorDefinitions,
		m.clCompileUndefinePreprocessorDefinitions,
		m.clCompileAdditionalIncludeDirectories,
		m.clCompileAdditionalUsingDirectories,
		m.forceIncludes,
		m.debugInformationFormat,
		m.optimization,
		m.functionLevelLinking,
		m.intrinsicFunctions,
		m.justMyCodeDebugging,
		m.supportOpenMP,
		m.minimalRebuild,
		m.omitFramePointers,
		m.stringPooling,
		m.runtimeLibrary,
		m.omitDefaultLib,
		m.exceptionHandling,
		m.runtimeTypeInfo,
		m.bufferSecurityCheck,
		m.treatWChar_tAsBuiltInType,
		m.floatingPointModel,
		m.floatingPointExceptions,
		m.inlineFunctionExpansion,
		m.enableEnhancedInstructionSet,
		m.multiProcessorCompilation,
		m.additionalCompileOptions,
		m.compileAs,
		m.callingConvention,
		m.languageStandard,
		m.languageStandardC,
		m.conformanceMode,
		m.structMemberAlignment,
		m.useFullPaths,
		m.removeUnreferencedCodeData,
		m.compileAsWinRT,
		m.externalWarningLevel,
		m.externalAngleBrackets,
		m.scanSourceForModuleDependencies,
		m.useStandardPreprocessor,
	}

	if cfg.kind == p.STATICLIB then
		table.insert(calls, m.programDatabaseFileName)
	end

	return calls
end