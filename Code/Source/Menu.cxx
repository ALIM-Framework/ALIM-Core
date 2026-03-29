module;

#include <imgui.h>
#include <imgui_impl_win32.h>
#include <imgui_impl_dx11.h>
#include <imgui_internal.h>
#include <imstb_textedit.h>

module Menu;
import Present;
import Logger;
import AI;
import Offsets;
import <Windows.h>;
import <d3d11.h>;
import <cmath>;
import <cstdint>;
import <cstdio>;
import <print>;
import <type_traits>;

using namespace ALIM;

static bool GetDeviceAndContextFromSwapChain(IDXGISwapChain* pSwapChain, ID3D11Device** ppDevice, ID3D11DeviceContext** ppContext);

static void* GetActiveCharactersInstance() {
    if (AI::Globals::ActiveCharacters)
        return AI::Globals::ActiveCharacters;

    auto** GlobalsPtr = reinterpret_cast<AI::Structs::GameGlobals**>(Offsets::Globals::GameGlobals);
    if (!GlobalsPtr)
        return nullptr;
    auto* Globals = *GlobalsPtr;
    if (!Globals)
        return nullptr;
    return Globals->active_characters;
}

static AI::Structs::ActiveCharactersBucket* GetActiveCharactersBucket(void* ActiveCharacters, size_t Offset) {
    if (!ActiveCharacters)
        return nullptr;
    return reinterpret_cast<AI::Structs::ActiveCharactersBucket*>(reinterpret_cast<BYTE*>(ActiveCharacters) + Offset);
}

// Menu Class
//------------------------------------------------------------------------
void Menu::Render() {
    if (!_Enabled)
        return;

    if (ImGui::Begin("CATHODE Debug", &_Enabled)) {
        auto* EM = reinterpret_cast<AI::Structs::EntityManager*>(AI::Globals::EntityManager);
        if (EM) {
            ImGui::Text("EntityManager: %p", EM);

            if (ImGui::BeginTabBar("CATHODETabs")) {
                if (ImGui::BeginTabItem("Entities")) {
                    if (ImGui::CollapsingHeader("Temporary Entities", ImGuiTreeNodeFlags_DefaultOpen)) {
                auto Container = EM->temp_entities;
                if (Container && Container->entities) {
                    static int SelectedEntityIndex = -1;
                    static ImGuiTextFilter EntityFilter;
                    static bool NamedOnly = false;
                    static bool FlaggedOnly = false;

                    ImGui::Text("Count: %d", Container->count);
                    EntityFilter.Draw("Search", 220.0f);
                    ImGui::SameLine();
                    ImGui::Checkbox("Named only", &NamedOnly);
                    ImGui::SameLine();
                    ImGui::Checkbox("Bit15 only", &FlaggedOnly);

                    ImGui::Separator();
                    ImGui::BeginChild("EntityList", ImVec2(360.0f, 420.0f), true);

                    int VisibleCount = 0;
                    for (int i = 0; i < Container->count; ++i) {
                        auto Entity = Container->entities[i];
                        if (!Entity || !Entity->data || !AI::Globals::StringTable)
                            continue;

                        int InstanceOffset = AI::Functions::StringTable::Offset_From_Hash(AI::Globals::StringTable, &Entity->data->instance_guid);
                        int ClassOffset = AI::Functions::StringTable::Offset_From_Hash(AI::Globals::StringTable, &Entity->data->class_guid);

                        const char* InstanceName = (InstanceOffset != -1) ? AI::Functions::StringTable::ShortGuid_ToString(AI::Globals::StringTable, InstanceOffset) : "Unnamed";
                        const char* ClassName = (ClassOffset != -1) ? AI::Functions::StringTable::ShortGuid_ToString(AI::Globals::StringTable, ClassOffset) : "Unknown Class";
                        bool HasName = (InstanceOffset != -1) || (ClassOffset != -1);
                        bool Bit15 = (Entity->data->flags & 0x8000u) != 0;

                        if (NamedOnly && !HasName)
                            continue;
                        if (FlaggedOnly && !Bit15)
                            continue;

                        char FilterText[256] = {};
                        std::snprintf(FilterText, sizeof(FilterText), "%d %s %s %p", i, InstanceName, ClassName, Entity);
                        if (!EntityFilter.PassFilter(FilterText))
                            continue;

                        ++VisibleCount;

                        ImGui::PushID(i);
                        if (Bit15)
                            ImGui::PushStyleColor(ImGuiCol_Text, IM_COL32(230, 190, 120, 255));

                        bool IsSelected = (SelectedEntityIndex == i);
                        if (ImGui::Selectable(FilterText, IsSelected))
                            SelectedEntityIndex = i;

                        if (Bit15)
                            ImGui::PopStyleColor();
                        ImGui::PopID();
                    }

                    if (VisibleCount == 0)
                        ImGui::TextDisabled("No entities match the current filters.");

                    ImGui::EndChild();
                    ImGui::SameLine();

                    ImGui::BeginChild("EntityDetails", ImVec2(0.0f, 420.0f), true);
                    if (SelectedEntityIndex >= 0 && SelectedEntityIndex < Container->count) {
                        auto Entity = Container->entities[SelectedEntityIndex];
                        if (Entity && Entity->data && AI::Globals::StringTable) {
                            int InstanceOffset = AI::Functions::StringTable::Offset_From_Hash(AI::Globals::StringTable, &Entity->data->instance_guid);
                            int ClassOffset = AI::Functions::StringTable::Offset_From_Hash(AI::Globals::StringTable, &Entity->data->class_guid);

                            const char* InstanceName = (InstanceOffset != -1) ? AI::Functions::StringTable::ShortGuid_ToString(AI::Globals::StringTable, InstanceOffset) : "Unnamed";
                            const char* ClassName = (ClassOffset != -1) ? AI::Functions::StringTable::ShortGuid_ToString(AI::Globals::StringTable, ClassOffset) : "Unknown Class";

                            auto* TempEnt = reinterpret_cast<AI::Structs::TemporaryEntityData*>(Entity->data);
                            auto* CEnt = reinterpret_cast<void*>(TempEnt);
                            void** CVTable = *reinterpret_cast<void***>(CEnt);

                            ImGui::Text("Entity [%d]", SelectedEntityIndex);
                            ImGui::Separator();
                            ImGui::Text("Instance: %s", InstanceName);
                            ImGui::Text("Class: %s", ClassName);
                            ImGui::Text("Handle: %p", Entity);
                            ImGui::Text("Entity: %p", TempEnt);
                            ImGui::Text("Alloc Vtable: %p", Entity->vtable);
                            ImGui::Text("Entity Vtable: %p", CVTable);
                            ImGui::Text("Instance GUID: 0x%08X", Entity->data->instance_guid);
                            ImGui::Text("Class GUID: 0x%08X", Entity->data->class_guid);

                            ImGui::Separator();

                            DWORD flags = Entity->data->flags;
                            bool bit15 = (flags & 0x8000u) != 0;

                            using tQueryManagerStateIfFlagged = void* (__thiscall*)(void*, void**, AI::Structs::Entity**);
                            auto QueryManagerStateIfFlaggedFn = reinterpret_cast<tQueryManagerStateIfFlagged>(CVTable[71]);

                            AI::Structs::Entity* EntityHandle = Entity;
                            void* ManagerState = nullptr;
                            QueryManagerStateIfFlaggedFn(CEnt, &ManagerState, &EntityHandle);

                            ImGui::Text("Flags: 0x%08X", flags);
                            ImGui::Text("Bit15: %s", bit15 ? "set" : "clear");
                            ImGui::Text("Manager State: %p", ManagerState);
                            ImGui::TextDisabled("Manager State is only expected when bit15 is set.");

                            ImGui::Separator();

                            ImGui::Text("Linked Entity Ref: %p", reinterpret_cast<void*>(TempEnt->linked_entity_ref));
                        } else {
                            ImGui::TextDisabled("Selected entity is no longer valid.");
                        }
                    } else {
                        ImGui::TextDisabled("Select an entity from the list.");
                    }
                    ImGui::EndChild();
                } else {
                    ImGui::Text("No temporary entities container.");
                }
            }

                    if (EM->root_instance) {
                        ImGui::Separator();
                        ImGui::Text("Root Instance: %p", EM->root_instance);
                        ImGui::Text("Ref Count: %d", EM->root_instance->ref_count);
                    }

                    ImGui::EndTabItem();
                }

                if (ImGui::BeginTabItem("Active Characters")) {
                    void* ActiveCharacters = GetActiveCharactersInstance();
                    ImGui::Text("ActiveCharacters: %p", ActiveCharacters);

                    static int SelectedBucket = 0;
                    static int SelectedCharacterIndex = -1;
                    constexpr size_t BucketOffsets[5] = {
                        offsetof(AI::Structs::ActiveCharacters, staged_bucket),
                        offsetof(AI::Structs::ActiveCharacters, idle_bucket),
                        offsetof(AI::Structs::ActiveCharacters, active_npc_bucket),
                        offsetof(AI::Structs::ActiveCharacters, bucket_3),
                        offsetof(AI::Structs::ActiveCharacters, bucket_4)
                    };
                    constexpr const char* BucketNames[5] = {
                        "Staged",
                        "Idle / Default",
                        "Active NPCs",
                        "Bucket 3",
                        "Bucket 4"
                    };

                    for (int BucketIndex = 0; BucketIndex < 5; ++BucketIndex) {
                        auto* Bucket = GetActiveCharactersBucket(ActiveCharacters, BucketOffsets[BucketIndex]);
                        int Count = Bucket ? static_cast<int>(Bucket->count) : 0;
                        //ImGui::SameLine(BucketIndex == 0 ? 0.0f : 12.0f);
                        if (ImGui::Selectable(BucketNames[BucketIndex], SelectedBucket == BucketIndex, 0, ImVec2(80.0f, 0.0f))) {
                            SelectedBucket = BucketIndex;
                            SelectedCharacterIndex = -1;
                        }
                        if (Count > 0) {
                            //ImGui::SameLine();
                            ImGui::TextDisabled("(%d)", Count);
                        }
                    }

                    ImGui::Separator();

                    auto* ActiveBucket = GetActiveCharactersBucket(ActiveCharacters, BucketOffsets[SelectedBucket]);
                    if (ActiveBucket && ActiveBucket->entries && ActiveBucket->count > 0) {
                        ImGui::BeginChild("ActiveCharacterList", ImVec2(360.0f, 420.0f), true);
                        for (unsigned int i = 0; i < ActiveBucket->count; ++i) {
                            auto* RuntimeCharacter = reinterpret_cast<AI::Structs::RuntimeCharacter*>(ActiveBucket->entries[i]);
                            if (!RuntimeCharacter)
                                continue;

                            AI::Structs::Vector3f Pos{ RuntimeCharacter->position.x, RuntimeCharacter->position.y, RuntimeCharacter->position.z };

                            char Label[128] = {};
                            std::snprintf(Label, sizeof(Label), "%u: %p (%.2f, %.2f, %.2f)", i, RuntimeCharacter, Pos.x, Pos.y, Pos.z);
                            if (ImGui::Selectable(Label, SelectedCharacterIndex == static_cast<int>(i)))
                                SelectedCharacterIndex = static_cast<int>(i);
                        }
                        ImGui::EndChild();
                        ImGui::SameLine();

                        ImGui::BeginChild("ActiveCharacterDetails", ImVec2(0.0f, 420.0f), true);
                        if (SelectedCharacterIndex >= 0 && SelectedCharacterIndex < static_cast<int>(ActiveBucket->count)) {
                            auto* Character = ActiveBucket->entries[SelectedCharacterIndex];
                            if (Character) {
                                auto* RuntimeCharacter = reinterpret_cast<AI::Structs::RuntimeCharacter*>(Character);

                                AI::Structs::Vector3f Pos{ RuntimeCharacter->position.x, RuntimeCharacter->position.y, RuntimeCharacter->position.z };

                                ImGui::Text("Character: %p", Character);
                                ImGui::Separator();
                                ImGui::Text("Bucket: %s", BucketNames[SelectedBucket]);
                                ImGui::Text("Bucket Entry: %d", SelectedCharacterIndex);
                                ImGui::Text("Runtime Id: %d", RuntimeCharacter->runtime_id);
                                ImGui::Text("Position: %.3f, %.3f, %.3f", Pos.x, Pos.y, Pos.z);
                                ImGui::Text("u32_84: 0x%08X", RuntimeCharacter->u32_84);
                                ImGui::Text("u32_88: 0x%08X", RuntimeCharacter->u32_88);
                                ImGui::Text("u16_1120: %u", static_cast<unsigned int>(RuntimeCharacter->u16_1120));
                                ImGui::Text("u8_1122: %u", static_cast<unsigned int>(RuntimeCharacter->u8_1122));
                                ImGui::Text("u32_1124: 0x%08X", RuntimeCharacter->u32_1124);
                                ImGui::Text("u32_1128: %u", RuntimeCharacter->u32_1128);
                                ImGui::Text("u8_708: %u", static_cast<unsigned int>(RuntimeCharacter->u8_708));
                                ImGui::Text("u8_761: %u", static_cast<unsigned int>(RuntimeCharacter->u8_761));
                                ImGui::Text("u8_771: %u", static_cast<unsigned int>(RuntimeCharacter->u8_771));
                                ImGui::Text("Type State: %p", RuntimeCharacter->type_state);
                                ImGui::Text("State Object: %p", RuntimeCharacter->state_object);
                                ImGui::Text("embedded_refcounted.vtable: %p", RuntimeCharacter->embedded_refcounted.vtable);
                                ImGui::Text("i32_11444: %d", RuntimeCharacter->i32_11444);
                            } else {
                                ImGui::TextDisabled("Selected runtime character is null.");
                            }
                        } else {
                            ImGui::TextDisabled("Select a runtime character.");
                        }
                        ImGui::EndChild();
                    } else {
                        ImGui::TextDisabled("No runtime characters in selected bucket.");
                    }

                    ImGui::EndTabItem();
                }

                ImGui::EndTabBar();
            }
        } else {
            ImGui::TextColored(ImVec4(1, 0, 0, 1), "EntityManager Instance not found (is the game loaded?)");
        }
    }
    ImGui::End();
}
