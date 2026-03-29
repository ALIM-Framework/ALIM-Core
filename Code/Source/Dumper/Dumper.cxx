module;
#include <time.h>

module Dumper;

import Console;
import Logger;
import Memory;
import Arguments;

import <chrono>;
import <fstream>;
import <thread>;
import <sstream>;
import <print>;
import <filesystem>;
import <vector>;

import <Windows.h>;

using namespace ALIM;

struct SignatureValue {
    std::string Name;
    std::string Pattern;
};

struct Node {
    std::string Name;
    std::vector<SignatureValue> Values;
    std::vector<Node> Children;
};

static Node BuildSignatureTree() {
    return {
        "",
        {},
        {
            {
                "STD_LEVEL",
                {
                    { "Open", "55 8B EC 83 E4 F8 6A FF 68 ?? ?? ?? ?? 64 A1 00 00 00 00 50 64 89 25 00 00 00 00 81 EC 94" },
                    { "Restart", "6A FF 68 ?? ?? ?? ?? 64 A1 ?? ?? ?? ?? 50 64 89 25 ?? ?? ?? ?? 83 EC 0C 53 8B 1D ?? ?? ?? ??" }
                },
                {}
            },
            {
                "UI",
                {},
                {
                    {
                        "LEVELMANAGER",
                        {
                            { "GetLayer", "E8 ?? ?? ?? ?? F3 0F 10 90 ?? ?? ?? ??" },
                            { "Render", "E8 ?? ?? ?? ?? B9 ?? ?? ?? ?? E8 ?? ?? ?? ?? F3 0F 10 05 ?? ?? ?? ??" }
                        },
                        {}
                    },
                    {
                        "AUDIO_CALLBACK",
                        {
                            { "TriggerSoundEvent", "E8 ?? ?? ?? ?? 80 66 0C EF" }
                        },
                        {}
                    }
                }
            },
            {
                "CATHODE",
                {},
                {
                    {
                        "TASKS",
                        {
                            { "Add", "8B 44 24 08 56 6A 00 6A" }
                        },
                        {}
                    },
                    {
                        "Entity_Manager",
                        {
                            { "Init", "55 8B EC 6A FF 68 ?? ?? ?? ?? 64 A1 00 00 00 00 50 83 EC 08 53 56 A1 ?? ?? ?? ?? 33 C5 50 8D 45 F4 64 A3 00 00 00 00 8B F1 89 75 F0" }
                        },
                        {}
                    },
                    {
                        "Entity_Variable",
                        {
                            { "GetTransformMatrix", "55 8B EC 81 EC ?? ?? ?? ?? 56 8B F1 8B 46 ?? 85 C0" },
                            { "GetPositionVariableMatrix", "55 8B EC ?? ?? ?? ?? ?? ?? 56 8B 75 ?? ?? ?? 8B 45 ?? ?? ?? ?? ?? ?? ?? 56 ?? ?? ?? 68 ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? 50 ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? E8 ?? ?? ?? ?? 8B C6 5E 5D C2" }
                        },
                        {}
                    },
                    {
                        "Temporary_Entity",
                        {
                            { "SyncRuntimeStates", "55 8B EC 6A ?? 68 ?? ?? ?? ?? 64 A1 ?? ?? ?? ?? 50 83 EC ?? 53 56 57 A1 ?? ?? ?? ?? 33 C5 50 8D 45 ?? 64 A3 ?? ?? ?? ?? 8B D9 89 5D ?? 8B 43 ?? 8B 75" }
                        },
                        {}
                    },
                    {
                        "Handle",
                        {
                            { "GetTransformMatrixOrDefault", "55 8B EC 6A ?? 68 ?? ?? ?? ?? 64 A1 ?? ?? ?? ?? 50 83 EC ?? 53 56 57 A1 ?? ?? ?? ?? 33 C5 50 8D 45 ?? 64 A3 ?? ?? ?? ?? 8B D9 89 5D ?? 8B 43 ?? 8B 75" }
                        },
                        {}
                    },
                    {
                        "Runtime_Object",
                        {
                            { "ResolveRef", "55 8B EC 6A ?? 68 ?? ?? ?? ?? 64 A1 ?? ?? ?? ?? 50 83 EC ?? 53 56 57 A1 ?? ?? ?? ?? 33 C5 50 8D 45 ?? 64 A3 ?? ?? ?? ?? 8B F9 33 C9" },
                            { "GetCharacter", "0x8B4760" },
                            { "GetLogicCharacter", "0x8B4810" }
                        },
                        {}
                    },
                    {
                        "Composite_Interface",
                        {
                            { "GetActorCharacter", "55 8B EC 6A ?? 68 ?? ?? ?? ?? 64 A1 ?? ?? ?? ?? 50 51 53 56 57 A1 ?? ?? ?? ?? 33 C5 50 8D 45 ?? 64 A3 ?? ?? ?? ?? 33 F6 89 75 ?? 8B 55 ?? 8D 45 ?? 50 68 ?? ?? ?? ?? 52 89 75 ?? E8 ?? ?? ?? ?? 8D 45 ?? 50 E8 ?? ?? ?? ?? 8B D8 8B 45 ?? 83 C4 ?? C7 45 ?? ?? ?? ?? ?? 3B C6 74 ?? 8B 48 ?? 83 F9 ?? 75 ?? 8B 55 ?? 8B 4A ?? ?? ?? 8B 50 ?? 56 FF D2 8B 45 ?? 8D 70 ?? 8B F8 8B C6 83 C9 ?? ?? ?? ?? ?? 49 41 83 F9 ?? 75 ?? 8B CF E8 ?? ?? ?? ?? 3B 3D ?? ?? ?? ?? 75 ?? ?? ?? 52 E8 ?? ?? ?? ?? 83 C4 ?? 8B C3 8B 4D ?? 64 89 0D ?? ?? ?? ?? 59 5F 5E 5B 8B E5 5D C2" },
                            { "GetTacticalPositionMatrix", "55 8B EC ?? ?? ?? ?? ?? ?? 56 8B 75 ?? ?? ?? 8B 45 ?? ?? ?? ?? ?? ?? ?? 56 ?? ?? ?? 68 ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? 50 ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? E8 ?? ?? ?? ?? 8B C6 5E 5D C2" }
                        },
                        {}
                    },
                    {
                        "Entity_Object",
                        {
                            { "GetHandlePair", "55 8B EC 51 56 8B F1 8B 46 ?? 85 C0 74 ?? 8D 4D" }
                        },
                        {}
                    },
                    {
                        "Character_Manager",
                        {
                            { "Get", "A1 ?? ?? ?? ?? C3" },
                            { "FindByHandle", "83 EC ?? 33 C0 89 4C 24 ?? 38 41" }
                        },
                        {}
                    }
                }
            },
            {
                "Globals",
                {
                    { "GameGlobals", "0x16F0C88" }
                },
                {}
            },
            {
                "StringTable",
                {
                    { "New", "55 8B EC 6A ?? 68 ?? ?? ?? ?? 64 A1 ?? ?? ?? ?? 50 51 56 A1 ?? ?? ?? ?? 33 C5 50 8D 45 ?? 64 A3 ?? ?? ?? ?? 6A ?? E8" },
                    { "Offset_From_Hash", "55 8B EC 83 EC ?? 8B 45 ?? ?? ?? 8B 41" },
                    { "ShortGuid_ToString", "55 8B EC 8B 45 ?? 83 F8 ?? 75 ?? B8 ?? ?? ?? ?? 5D C2" }
                },
                {}
            },
            {
                "RENDER",
                {
                    { "SetCurrentRenderTarget", "E8 ?? ?? ?? ?? 8B 35 ?? ?? ?? ?? 83 C4 04 3B F3" }
                },
                {
                    {
                        "GFX",
                        {
                            { "SetRenderTargets", "E8 ?? ?? ?? ?? 83 C4 10 8D 44 24 54" },
                            { "DX11_GetNativeRenderTarget", "E8 ?? ?? ?? ?? 8B 54 24 24 8B D8" }
                        },
                        {}
                    }
                }
            }
        }
    };
}

namespace {

static std::string GetTimeFormatted() {
    using namespace std::chrono;
    const system_clock::time_point Now = system_clock::now();
    const std::time_t Time = system_clock::to_time_t(Now);

    std::tm TimeInfo = {};
    localtime_s(&TimeInfo, &Time);

    char TimeString[20];
    std::strftime(TimeString, sizeof(TimeString), "%d/%m/%Y %H:%M:%S", &TimeInfo);

    return std::string(TimeString);
}

std::string EscapeString(const std::string& Input) {
    std::string Escaped;
    for (size_t i = 0; i < Input.length(); i++) {
        if (Input[i] == '\\' && i + 1 < Input.length() && Input[i + 1] == 'x') {
            if (i + 3 < Input.length()) {
                // Extract the hex value (2 characters) and convert it to an integer
                std::string hexValue = Input.substr(i + 2, 2);
                char escapedChar = static_cast<char>(std::stoi(hexValue, 0, 16));

                // Append the escaped charactre to the result string
                Escaped += escapedChar;

                // Skip
                i += 3;
            } else {
                // If there are not enough characters for a valid escape sequence, just add the '\\x' as-is
                Escaped += "\\x";
            }
        } else {
            Escaped += Input[i];
        }
    }

    return Escaped;
}

} // namespace

std::string NodeToNamespace(const Node& node, const std::string& indent = "") {
    std::stringstream Stream;

    for (const SignatureValue& value : node.Values) {
        ALIM_CORE_DEBUG("Scanning {}: {}", value.Name, value.Pattern);

        uintptr_t Offset = 0x0;
        if (value.Pattern.find("0x") != std::string::npos) {
            try {
                Offset = std::stoull(value.Pattern, nullptr, 16);
            } catch (const std::exception& e) {
                ALIM_CORE_ERROR("Failed parsing offset for {}: {}", value.Name, e.what());
            }
        } else {
            Offset = Memory::FindPattern(value.Pattern);
        }
        Stream << indent << "constexpr uintptr_t " << value.Name << " = 0x" << std::uppercase << std::hex << Offset << ";\n";

        if (!Offset)
            ALIM_CORE_ERROR("Could not find offset for {}", value.Name);
    }

    int childCount = static_cast<int>(node.Children.size());
    for (const Node& child : node.Children) {
        Stream << indent + "namespace " + child.Name + " {\n";
        Stream << NodeToNamespace(child, indent + "    ");
        Stream << indent + "}";
        if (--childCount > 0) {
            Stream << "\n\n";  // Add newline between namespaces
        }
        Stream << "\n";  // Add newline after namespace
    }

    return Stream.str();
}

// Dumper Functions
//------------------------------------------------------------------------
void Dumper::Dump() {
    const Node Root = BuildSignatureTree();
    const std::string ParsedToNamespace = NodeToNamespace(Root, "    ");

    std::stringstream OutBuffer;
    OutBuffer << "//------------------------------------------------------------------------\n"
              << "// Generated by " << __FILE__ "\n"
              << "// Date: " << GetTimeFormatted() << "\n"
              << "//------------------------------------------------------------------------\n"
              << "export module Offsets;\n\n"
              << "import <cstdint>;\n\n"
              << "export namespace ALIM::Offsets {\n";

    OutBuffer << ParsedToNamespace;
    OutBuffer << "} // ALIM::Offsets";

    auto OutString = OutBuffer.str();
    ALIM_CORE_DEBUG("\n{}", OutString);

    if (Args::GetCommandLineOption("dump-to-clipboard")) {
        auto GlobalMem = GlobalAlloc(GMEM_FIXED, OutString.size());
        memcpy(GlobalMem, OutString.data(), OutString.size());
        
        OpenClipboard(nullptr);
        EmptyClipboard();
        SetClipboardData(CF_TEXT, GlobalMem);
        CloseClipboard();
    
        ALIM_CORE_INFO("Dumped Offsets to Clipboard!");
    } else { // Default
        std::string Filepath = Args::GetCommandLineVar<std::string>("dump-path");

        namespace fs = std::filesystem;

        fs::path CompletePath;
        
        if (!Filepath.empty() && fs::path(Filepath).has_parent_path()) {
            if (fs::is_directory(Filepath)) { // If we just specified a directory
                CompletePath = fs::path(Filepath) / "Offsets.ixx";
            } else { // Directory + File
                CompletePath = Filepath;
            }
        } else {
            std::string DefaultDir = Args::GetCommandLineVar<std::string>("launch-dir");
            if (!DefaultDir.empty()) {
                DefaultDir = fs::path(DefaultDir).string();
            }
        
            CompletePath = fs::path(DefaultDir) / "Offsets.ixx";
        }
        
        std::ofstream Outfile(CompletePath.string(), std::ios::out | std::ios::trunc);
        Outfile << OutString;
        Outfile.close();

        ALIM_CORE_INFO("Dumped to {}", CompletePath.string());
    }
}
