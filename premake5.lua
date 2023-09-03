VCPKG_ROOT = os.getenv("VCPKG_ROOT")

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

    files {
		"Source/**.cpp", "Modules/**.ixx", "Modules/**.cxx",
        "Submodules/cimgui/cimgui.cpp",
        "Submodules/cimgui/imgui/imgui.cpp",
        "Submodules/cimgui/imgui/imgui_draw.cpp",
        "Submodules/cimgui/imgui/imgui_demo.cpp",
        "Submodules/cimgui/imgui/imgui_widgets.cpp",
        "Submodules/cimgui/imgui/imgui_tables.cpp",
        "Submodules/cimgui/imgui/backends/imgui_impl_win32.cpp",
        "Submodules/cimgui/imgui/backends/imgui_impl_dx11.cpp"
	}
	
    includedirs {
        VCPKG_ROOT .. "/installed/x86-windows-static/include", -- TODO: Remove and replace with each one, that way there's no issues in the future (like having lua and luajit installed)
        VCPKG_ROOT .. "/installed/x86-windows-static/include/luajit",
        "Submodules/Sol2/include",
        "Submodules/cimgui",
		"Submodules/cimgui/imgui",
		"Submodules/cimgui/imgui/backends",
        "Include"
    }

    filter "configurations:Debug"
        defines { "DEBUG", "_ITERATOR_DEBUG_LEVEL=2", "SPDLOG_ACTIVE_LEVEL=SPDLOG_LEVEL_TRACE", "IMGUI_DISABLE_OBSOLETE_FUNCTIONS=1" }
        libdirs { VCPKG_ROOT .. "/installed/x86-windows-static/debug/lib", "Submodules/cimgui/cmake_build/build32/Debug" }
        links { "minhook.x32d", "spdlogd", "fmtd", "lua51", "imm32" }

        symbols "On"
        runtime "Debug"

    filter "configurations:Release"
        defines { "NDEBUG" }
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
        function(cfg) m.element("EnableModules", nil, "false") end, -- spdlog won't work if enabled due to `localtime_s`, typical module issues...
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