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

    -- TODO: Improve this for the Dumper
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