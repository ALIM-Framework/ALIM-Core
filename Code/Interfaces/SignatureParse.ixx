export module SignatureParse;
import <string_view>;
import <string>;
import <fstream>;
import <print>;
import <stack>;
import <optional>;
import <functional>;
import <vector>;

constexpr char COMMENT = '#';

struct Signature {
    std::string Token;
    std::string Mask;
};

struct SectionValue {
    std::string Name;
    Signature   Sig;
};

export struct SectionNode {
    std::string                Name;
    std::vector<SectionNode>   Children;
    std::vector<SectionValue>  Values;
    bool                       Inlined;
};

std::vector<std::string> Split(const std::string& Input, const std::string& Delimiter) {
    std::vector<std::string> Tokens;
    size_t start = 0, end = 0;
    
    while ((end = Input.find(Delimiter, start)) != std::string::npos) {
        Tokens.push_back(Input.substr(start, end - start));
        start = end + Delimiter.length();
    }
    
    Tokens.push_back(Input.substr(start));
    return Tokens;
}

std::vector<std::string> ParseSectionName(const std::string& Line) {
    if (Line.front() != '[' && Line.back() != '{')
        return {};

    std::vector<std::string> Sections = {};
    Sections.reserve(1);

    std::string SectionName = Line.substr(1, Line.size() - 6);
    SectionName.erase(0, SectionName.find_first_not_of("\t\n\v\f\r "));
    if (SectionName.front() == '[') {
        SectionName.erase(SectionName.begin());
    }

    // Split by :: and push
    std::vector<std::string> SetionNames = Split(SectionName, "::");
    if (SectionName.size() == 0) {
        Sections.emplace_back(SectionName);
    } else {
        for (const auto& SectionName : SetionNames) {
            Sections.emplace_back(SectionName);
        }
    }

    return Sections;
}

std::optional<SectionNode> GetNodeFromName(std::vector<SectionNode>& Nodes, std::string_view Name) {
    if (Nodes.size() == 0)
        return std::nullopt;

    for (SectionNode& Node : Nodes) {
        if (Node.Name == Name) {
            return Node;
        } else if (Node.Children.size() >= 1) {
            auto ChildNodeOpt = GetNodeFromName(Node.Children, Name);
            if (ChildNodeOpt.has_value()) {
                return *ChildNodeOpt;
            }
        }
    }

    return std::nullopt;
}

void SetNodeValues(std::vector<SectionNode>& Nodes, std::string_view Name, const std::vector<SectionValue>& NewValues) {
    for (size_t i = 0; i < Nodes.size(); i++) {
        SectionNode Node = Nodes[i];

        if (Node.Name == Name) {
            Nodes[i].Values = NewValues;
            return;
        } else if (Node.Children.size() >= 1) {
            SetNodeValues(Node.Children, Name, NewValues);
        }
    }
}

bool IsInlined(const SectionNode& Node) {
    return Node.Inlined;
}

std::size_t GetInlinedCount(const SectionNode& Node) {
    std::size_t Result = IsInlined(Node) ? 1 : 0;

    for (size_t i = 0; i < Node.Children.size(); i++) {
        Result += GetInlinedCount(Node.Children[i]);
    }

    return Result;
}

namespace ALIM::SigParse {
    export std::vector<SectionNode> ParseFile(std::string_view Filepath) {
        std::ifstream File(Filepath.data());
        if (!File.is_open()) {
            // TODO: Error
            return {};
        }

        std::stack<std::string> SectionNames;
        std::vector<SectionNode> Nodes;
        SectionNode CurrentNode;

        // PopNode
        //------------------------------------------------------------------------
        std::function<void(std::string_view)> PopNode;
        PopNode = [&](std::string_view Name) {
            //std::println("Popping {}", Name);

 //           auto NodeOpt = GetNodeFromName(CurrentNode.Name);
 //           if (NodeOpt) {
 //               SectionNode* Node = *NodeOpt;
 //               Node.back().Values = CurrentNode.Values;
 //           }

            std::string SectionName = SectionNames.top();
            SectionNames.pop();
            if (SectionNames.size() >= 1) {
                SectionName = SectionNames.top();
                auto CurrentNodeOpt = GetNodeFromName(Nodes, SectionName);
                if (CurrentNodeOpt.has_value()) {
                    CurrentNode = *CurrentNodeOpt;
                }

                const std::size_t InlinedCount = GetInlinedCount(CurrentNode);

                if (InlinedCount > 0) {
                    for (std::size_t i = 0; i < InlinedCount; i++) {
                        if (SectionNames.size() > 0)
                            PopNode(SectionNames.top());
                        else break;
                    }
                }
            } else {
                CurrentNode = {};
            }
        };
        //------------------------------------------------------------------------

        std::string Line;
        while (std::getline(File, Line)) {
            if (Line.empty() || Line.find_first_not_of(" \t") == std::string::npos || Line.front() == COMMENT)
                continue;

            std::vector<std::string> LineSectionNames = ParseSectionName(Line);
            if (LineSectionNames.size() > 1) { // Inlined: [S1::S2::S3]
                bool IsRoot = CurrentNode.Name.empty();
                if (IsRoot) { // No root node
                    SectionNames.push(LineSectionNames[0]);
                    //std::println("Added Root for Inline: {}", LineSectionNames[0]);
                    //Nodes.push_back({ LineSectionNames[0] });
                    CurrentNode = { LineSectionNames[0] };
                }

                LineSectionNames.erase(LineSectionNames.begin()); // Remove the root
                for (const std::string_view& SectionName : LineSectionNames) {
                    SectionNames.push(SectionName.data());

                    // Create nested children
                    CurrentNode.Children.push_back({SectionName.data()});
                    CurrentNode.Children.back().Inlined = true;
                    //std::println("Added {} to {}", SectionName, CurrentNode.Name);

                    if (Nodes.size() == 0)
                        Nodes.push_back({CurrentNode.Name});

                    Nodes.back() = CurrentNode;
                    CurrentNode = CurrentNode.Children.back();
                }
            } else if (LineSectionNames.size() == 1)  { // Not Inlined: [S1]
                SectionNames.push(LineSectionNames[0]);
                Nodes.push_back({LineSectionNames[0]});

                //std::println("Added Non-Inline: {}", LineSectionNames[0]);
                CurrentNode = Nodes.back();
            } else if (Line.back() == '}' && SectionNames.size() > 0) { // We're in a Section / Node
                PopNode(SectionNames.top());
            } else {
                std::size_t ColonPos = Line.find(':');
                if (ColonPos == std::string::npos || CurrentNode.Name.empty())
                    continue;

                std::string Key = Line.substr(0, ColonPos);
                std::string StringValue = Line.substr(ColonPos + 1);

                Key.erase(0, Key.find_first_not_of(" \t"));
                Key.erase(Key.find_last_not_of(" \t") + 1);

                StringValue.erase(0, StringValue.find_first_not_of(" \t"));
                StringValue.erase(StringValue.find_last_not_of(" \t") + 1);

                std::vector<std::string> ValueParts = Split(StringValue, " ");
                Signature Sig = { ValueParts[0], ValueParts[1] };
                SectionValue Value = { Key, Sig };

                //Nodes.back().Values.push_back(Value);

                //std::println("[{}] Found {} - {}, {}", CurrentNode.Name, Key, ValueParts[0], ValueParts[1]);
            }
        }

        return Nodes;
    }
}