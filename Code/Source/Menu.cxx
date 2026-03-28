module;

#include <imgui.h>
#include <imgui_impl_win32.h>
#include <imgui_impl_dx11.h>
#include <imgui_internal.h>
#include <imstb_textedit.h>

module Menu;
import Present;
import Logger;
import Cathode;
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
        auto EM = *(Cathode::Structs::EntityManager**)Offsets::CATHODE::Entity_Manager::Instance;
        if (EM) {
            ImGui::Text("EntityManager: %p", EM);

            if (ImGui::CollapsingHeader("Temporary Entities")) {
                auto Container = EM->temp_entities;
                if (Container && Container->entities) {
                    ImGui::Text("Count: %d", Container->count);
                    for (int i = 0; i < Container->count; ++i) {
                        auto Entity = Container->entities[i];
                        if (Entity) {
                            ImGui::BulletText("Entity [%d]: %p (Data: %p)", i, Entity, Entity->data);
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