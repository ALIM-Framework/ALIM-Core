module;
#include <time.h>

module Dumper;

// Imports
//------------------------------------------------------------------------
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

// Helper Functions
//------------------------------------------------------------------------
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

// TODO: Make safe...
// static std::string ReplaceSignature(const std::string& Line) {
//     std::string Result = Line;
//     std::size_t StartPos = Result.find("_SIG(");
// 
//     while (StartPos != std::string::npos) {
//         std::size_t EndPos = Result.find(")", StartPos);
// 
//         if (EndPos != std::string::npos) {
//             std::string SigCall = Result.substr(StartPos, EndPos - StartPos + 1);
//             std::string Pattern, Mask = "";
// 
//             std::size_t CommaPos = SigCall.find(",");
//             if (CommaPos != std::string::npos) {
//                 Pattern = SigCall.substr(0, CommaPos);
//                 Pattern = Pattern.substr(6, Pattern.size() - 7);
// 
//                 Mask = SigCall.substr(CommaPos + 1);
//                 Mask = Mask.substr(2, Mask.size() - 4);
// 
//                 const std::string EscapedPattern = EscapeString(Pattern);
//                 const Memory::Signature Sig = Memory::Signature(EscapedPattern.c_str(), Mask.c_str());
//                 const uint32_t Offset = Memory::FindPattern(Sig);
// 
//                 if (!Offset) {
//                     ALIM_CORE_ERROR("Failed getting:\nPattern: {}\nMask: {}", Pattern, Mask);
//                     Result.replace(StartPos, EndPos - StartPos + 1, "0x0");
//                 } else {
//                     Result.replace(StartPos, EndPos - StartPos + 1, std::format("{:#x}", Offset));
//                 }
//             }
// 
//             StartPos = Result.find("_SIG(", StartPos + 1);
//         } else {
//             StartPos = Result.find("_SIG(", StartPos + 1);
//         }
//     }
// 
//     return Result;
// }

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
                    }
                }
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
