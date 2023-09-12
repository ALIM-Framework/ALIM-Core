export module Arguments;
import <string>;
import <string_view>;
import <Windows.h>;

std::string CommandLine;

export namespace ALIM::Arg {
    void SetCommandLine(const std::string& Args) {
        CommandLine = Args;
    }

    template <typename T>
    T GetCommandLineVar(const std::string& VarName) {  
        T VarValue = T();
    
        size_t Pos = CommandLine.find(VarName + "=");
        if (Pos != std::string::npos) {
            Pos += VarName.length() + 1;
            size_t EndPos = CommandLine.find(' ', Pos);
            if (EndPos == std::string::npos)
                EndPos = CommandLine.length();
    
            std::string ValueStr = CommandLine.substr(Pos, EndPos - Pos);
    
            // Remove surrounding quotes for string values
            if constexpr (std::is_same_v<T, std::string>) {
                if (!ValueStr.empty() && (ValueStr.front() == '"' || ValueStr.front() == '\''))
                    ValueStr = ValueStr.substr(1); // Remove leading quote
                if (!ValueStr.empty() && (ValueStr.back() == '"' || ValueStr.back() == '\''))
                    ValueStr = ValueStr.substr(0, ValueStr.length() - 1); // Remove trailing quote
                VarValue = ValueStr;
            } else if constexpr (std::is_same_v<T, int>) {
                std::istringstream ISS(ValueStr);
                ISS >> VarValue;
            } else if constexpr (std::is_same_v<T, bool>) {
                if (ValueStr == "true" || ValueStr == "1") {
                    VarValue = true;
                } else if (ValueStr == "false" || ValueStr == "0") {
                    VarValue = false;
                }
            }
        }
    
        return VarValue;
    }

    bool GetCommandLineOption(std::string_view Option) {
        size_t pos = CommandLine.find(std::string("--") + Option.data());
        if (pos != std::string::npos) {
            if (pos == 0 || CommandLine[pos - 1] == ' ' || CommandLine[pos - 1] == '-') {
                size_t endPos = pos + Option.length() + 2; // Move past the '--'
                if (endPos >= CommandLine.length() || CommandLine[endPos] == ' ' || CommandLine[endPos] == '\0') {
                    return true;
                }
            }
        }
        return false;
    }
}