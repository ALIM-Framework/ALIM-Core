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
import <iostream>;
import <cctype>;
import <expected>;
import <unordered_map>;

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

static inline void TrimLeft(std::string& s) {
    s.erase(s.begin(), std::find_if(s.begin(), s.end(), [](char ch){
        return !std::isspace(ch);
    }));
}

// Trim from end (in place)
static inline void TrimRight(std::string& s) {
    s.erase(std::find_if(s.rbegin(), s.rend(), [](char ch){
        return !std::isspace(ch);
    }).base(), s.end());
}

// Trim from both ends (in place)
static inline void Trim(std::string& s) {
    TrimLeft(s);
    TrimRight(s);
}

// static std::string ReplaceSignature(std::string& Line) {
//     Line.erase(Line.begin(), std::find_if(Line.begin(), Line.end(), [](char c) {
//         return !std::isspace(c);
//     }));
// 
//     if (Line.size() <= 1)
//         return Line;
// 
//     if (Line[0] == '/')
//         return Line;
// 
//     std::string Result = Line;
//     std::size_t StartPos = Result.find("_SIG2(");
//     while (StartPos != std::string::npos) {
//         std::size_t EndPos = Result.find(");", StartPos);
//         if (EndPos != std::string::npos) {
//             std::string SigCall = Result.substr(StartPos, EndPos - StartPos - 1);
//             std::string Pattern = "";
// 
//             Pattern = SigCall.substr(7);
//             bool Relative = Pattern[0] == 'E' && Pattern[1] == '8';
//             
//             uint32_t Offset = Memory::FindPattern(Pattern, Relative);
//             if (!Offset) {
//                 ALIM_CORE_ERROR("Failed getting: {}", Pattern);
//                 Result.replace(StartPos, EndPos - StartPos + 1, "0x0");
//             } else {
//                 Result.replace(StartPos, EndPos - StartPos + 1, std::format("{:#x}", Offset));
//             }
// 
//             StartPos = Result.find("_SIG2(", StartPos + 1);
//         } else {
//             StartPos = Result.find("_SIG2(", StartPos + 1);
//         }
//     }
//     return Result;
// }

struct Node {
    std::unordered_map<std::string, std::string> Values;
    std::unordered_map<std::string, Node> Children;
};

enum class ParseErrorCode : uint8_t {
    MISSING_CLOSING_BRACKET,
    INVALID_LINE_IN_SECTION,
    UNCLOSED_SECTION
};

struct ParseError {
    ParseErrorCode Code;
    std::string    Message;
};

std::expected<Node, ParseError> ParseFile(const std::string& Filename) {
    Node Root;
    std::ifstream File(Filename);
    std::string Line;
    std::vector<std::string> SectionStack;
    std::vector<Node*> NodeStack;
    NodeStack.push_back(&Root);

    int LineNumber = 0;
    while (std::getline(File, Line)) {
        LineNumber++;
        Trim(Line);
        // Ignore comments
        if (Line[0] == '#') continue;

        // Check for section
        if (Line[0] == '[') {
            size_t Start = 1;
            size_t End = Line.find("::", Start);
            Node* CurrentNode = NodeStack.back();
            while (End != std::string::npos) {
                std::string Section = Line.substr(Start, End - Start);
                CurrentNode = &CurrentNode->Children[Section];
                Start = End + 2;
                End = Line.find("::", Start);
            }
            End = Line.find(']', Start);
            std::string Section = Line.substr(Start, End - Start);
            CurrentNode = &CurrentNode->Children[Section];
            SectionStack.push_back(Section);
            NodeStack.push_back(CurrentNode);
            continue;
        }

        // Check for subsection
        size_t Pos = Line.find('[');
        if (Pos != std::string::npos) {
            size_t End = Line.find(']', Pos);
            std::string Section = Line.substr(Pos + 1, End - Pos - 1);
            Node* CurrentNode = NodeStack.back();
            CurrentNode = &CurrentNode->Children[Section];
            SectionStack.push_back(Section);
            NodeStack.push_back(CurrentNode);
            continue;
        }

        // Check for end of section or subsection
        if (Line[0] == '}') {
            if (NodeStack.size() > 1) {
                // std::cout << "Closing section: " << SectionStack.back() << "\n";
                SectionStack.pop_back();
                NodeStack.pop_back();
            } else {
                return std::unexpected<ParseError>({ ParseErrorCode::MISSING_CLOSING_BRACKET, std::to_string(LineNumber) });
            }
            continue;
        }

        // Check for key-value pair
        Pos = Line.find(':');
        if (Pos != std::string::npos) {
            std::string Key = Line.substr(0, Pos);
            std::string Value = Line.substr(Pos + 1);
            Trim(Key);
            Trim(Value);
            NodeStack.back()->Values[Key] = Value;
        } else if (!Line.empty()) {
            return std::unexpected<ParseError>({ ParseErrorCode::INVALID_LINE_IN_SECTION, std::format("Line [{}]: Invalid line in section {}: {}", LineNumber, SectionStack.back(), Line) });
        }
    }

    if (NodeStack.size() > 1) {
        return std::unexpected<ParseError>({ ParseErrorCode::UNCLOSED_SECTION, std::format("Line [{}]: Not all sections were closed. Unclosed section: {}", LineNumber, SectionStack.back()) });
    }

    return Root;
}

void PrintNode(const Node& node, const std::string& indent = "") {
    for (const auto& pair : node.Values) {
        std::cout << indent << pair.first << ": " << pair.second << "\n";
    }

    for (const auto& pair : node.Children) {
        std::cout << indent << "[" << pair.first << "]\n";
        PrintNode(pair.second, indent + "  ");
    }
}

std::string NodeToNamespace(const Node& node, const std::string& parent_namespace = "", const std::string& indent = "") {
    std::stringstream Stream;

    for (const auto& pair : node.Values) {
        ALIM_CORE_DEBUG("Scanning {}: {}", pair.first, pair.second);

        uintptr_t Offset = 0x0;
        if (pair.second.find("0x") != std::string::npos) {
            try {
                Offset = std::stoull(pair.second, nullptr, 16);
            } catch (const std::exception& e) {
                ALIM_CORE_ERROR("Failed parsing offset for {}: {}", pair.first, e.what());
            }
        } else {
            Offset = Memory::FindPattern(pair.second);
        }
        Stream << indent << "constexpr uintptr_t " << pair.first << " = 0x" << std::uppercase << std::hex << Offset << ";\n";

        if (!Offset)
            ALIM_CORE_ERROR("Could not find offset for {}", pair.first);
    }

    int childCount = node.Children.size();
    for (const auto& pair : node.Children) {
        std::string new_namespace = pair.first;
        Stream << indent + "namespace " + new_namespace + " {\n";
        Stream << NodeToNamespace(pair.second, new_namespace, indent + "    ");
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
    std::ifstream Signatures("DATA/ALIM/INTERNAL/SIGNATURES_NEW");
    if (!Signatures.is_open()) {
        MessageBoxW(nullptr, L"Unable to open \"DATA/ALIM/INTERNAL/SIGNATURES_NEW\"", L"ALIM-Core Dumper", MB_OK | MB_ICONERROR);
    }

    std::expected<Node, ParseError> ParseResult = ParseFile("DATA/ALIM/INTERNAL/SIGNATURES_NEW");
    if (!ParseResult.has_value()) {
        ParseError Error = ParseResult.error();
        ALIM_CORE_ERROR("Failed parsing signatures: ({}) {}", static_cast<uint8_t>(Error.Code), Error.Message);
        return;
    }

    Node Root = ParseResult.value();
    std::string ParsedToNamespace = NodeToNamespace(Root, "", "    ");

    std::string Line;
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