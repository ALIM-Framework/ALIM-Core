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
import <print>;
import <type_traits>;

using namespace ALIM;

static bool GetDeviceAndContextFromSwapChain(IDXGISwapChain* pSwapChain, ID3D11Device** ppDevice, ID3D11DeviceContext** ppContext);

// Menu Class
//------------------------------------------------------------------------
void Menu::Render() {
    if (!_Enabled)
        return;

    ALIM_CORE_DEBUG("Rendering Menu");

    if (ImGui::Begin("CATHODE Debug", &_Enabled)) {
        auto* EM = reinterpret_cast<AI::Structs::EntityManager*>(AI::Globals::EntityManager);
        if (EM) {
            ImGui::Text("EntityManager: %p", EM);

            if (ImGui::CollapsingHeader("Temporary Entities")) {
                auto Container = EM->temp_entities;
                if (Container && Container->entities) {
                    ImGui::Text("Count: %d", Container->count);
                    for (int i = 0; i < Container->count; ++i) {
                        auto Entity = Container->entities[i];
                        if (Entity && Entity->data && AI::Globals::StringTable) {
                            int InstanceOffset = AI::Functions::StringTable::Offset_From_Hash(AI::Globals::StringTable, &Entity->data->instance_guid);
                            int ClassOffset = AI::Functions::StringTable::Offset_From_Hash(AI::Globals::StringTable, &Entity->data->class_guid);

                            const char* InstanceName = (InstanceOffset != -1) ? AI::Functions::StringTable::ShortGuid_ToString(AI::Globals::StringTable, InstanceOffset) : nullptr;
                            const char* ClassName = (ClassOffset != -1) ? AI::Functions::StringTable::ShortGuid_ToString(AI::Globals::StringTable, ClassOffset) : nullptr;

                            auto SafeString = [](const char* str, const char* default_val) -> const char* {
                                if ((uintptr_t)str < 0x10000 || (uintptr_t)str > 0x7FFFFFFF) return default_val;
                                __try {
                                    if (str[0] == '\0') return default_val;
                                    return str;
                                } __except (EXCEPTION_EXECUTE_HANDLER) {
                                    return default_val;
                                }
                            };

                            ImGui::BulletText("Entity [%d]: %s (%s) [%p]", i, 
                                SafeString(InstanceName, "Unnamed"), 
                                SafeString(ClassName, "Unknown Class"),
                                Entity);
                        }
                    }
                } else {
                    ImGui::Text("No temporary entities container.");
                }
            }

            if (EM->root_instance) {
                ImGui::Separator();
                ImGui::Text("Root Instance: %p", EM->root_instance);
                ImGui::Text("Ref Count: %d", EM->root_instance->ref_count);
            }
        } else {
            ImGui::TextColored(ImVec4(1, 0, 0, 1), "EntityManager Instance not found (is the game loaded?)");
        }
    }
    ImGui::End();
}