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

    files { "Source/**.cpp", "Modules/**.ixx", "Modules/**.cxx" }
    includedirs { VCPKG_ROOT .. "/installed/x86-windows-static/include", "Include" }

    filter "configurations:Debug"
        defines { "DEBUG", "_ITERATOR_DEBUG_LEVEL=2", "SPDLOG_ACTIVE_LEVEL=SPDLOG_LEVEL_TRACE" }
        libdirs { VCPKG_ROOT .. "/installed/x86-windows-static/debug/lib" }
        links { "minhook.x32d", "imguid", "spdlogd", "fmtd" }

        symbols "On"
        runtime "Debug"

    filter "configurations:Release"
        defines { "NDEBUG" }
        libdirs { "$(VCPKG_ROOT)/installed/x86-windows-static/lib" }
        links { "minhook.x32", "imgui", "spdlog", "fmt" }

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