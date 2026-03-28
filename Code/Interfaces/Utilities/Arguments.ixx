export module Arguments;
import <string>;
import <string_view>;
import <Windows.h>;

std::string CommandLine;

export namespace ALIM::Args {
    void SetCommandLine(const std::string& Args) {
        CommandLine = Args;
    }

    template <typename T>
    T GetCommandLineVar(const std::string& VarName) {  
        T Value = T();
    
        size_t Pos = CommandLine.find(VarName + "=");
        if (Pos != std::string::npos) {
            Pos += VarName.length() + 1;
            size_t EndPos = CommandLine.find(' ', Pos);
            if (EndPos == std::string::npos)
                EndPos = CommandLine.length();
    
            std::string StrValue = CommandLine.substr(Pos, EndPos - Pos);
    
            if constexpr (std::is_same_v<T, std::string>) {
                // String
                if (!StrValue.empty() && (StrValue.front() == '"' || StrValue.front() == '\''))
                    StrValue = StrValue.substr(1); // Remove leading quote
                if (!StrValue.empty() && (StrValue.back() == '"' || StrValue.back() == '\''))
                    StrValue = StrValue.substr(0, StrValue.length() - 1); // Remove trailing quote
                Value = StrValue;
            } else if constexpr (std::is_same_v<T, bool>) {
                // Boolean
                if (StrValue == "true" || StrValue == "1") {
                    Value = true;
                } else if (StrValue == "false" || StrValue == "0") {
                    Value = false;
                }
            } else if constexpr (std::is_arithmetic_v<T>) {
                // Some other number
                std::istringstream ISS(StrValue);
                ISS >> Value;
            }
        }
    
        return Value;
    }

    bool GetCommandLineOption(std::string_view Option) {
        size_t pos = CommandLine.find(Option.data());
        if (pos == std::string::npos)
            return false;

        if (pos == 0 || CommandLine[pos - 1] == ' ' || CommandLine[pos - 1] == '-') {
            size_t endPos = pos + Option.length();
            if (endPos >= CommandLine.length() || CommandLine[endPos] == ' ' || CommandLine[endPos] == '\0') {
                return true;
            }
        }
        return false;
    }
}