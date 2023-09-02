import Menu;
import Present;
import <Windows.h>;
import <d3d11.h>;
import <print>;
import <type_traits>;

import <imgui.h>;
import <imgui_impl_dx11.h>;
import <imgui_impl_win32.h>;

using namespace ALIM;

static bool GetDeviceAndContextFromSwapChain(IDXGISwapChain* pSwapChain, ID3D11Device** ppDevice, ID3D11DeviceContext** ppContext);

// Menu Class
//------------------------------------------------------------------------
void Menu::Render() {
    if (!_ShowMenu || !ImGui::GetCurrentContext() || !Present::RenderTargetView)
        return;

    ImGui_ImplDX11_NewFrame();
    ImGui_ImplWin32_NewFrame();
    ImGui::NewFrame();
    
    {
        ImGui::ShowDemoWindow();
    }

    ImGui::EndFrame();
    ImGui::Render();

    Present::DeviceContext->OMSetRenderTargets(1, &Present::RenderTargetView, nullptr);
    ImGui_ImplDX11_RenderDrawData(ImGui::GetDrawData());
}

void Menu::Initialize(HWND hWnd) {
    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGui_ImplWin32_Init(hWnd);

    ImGuiIO& io = ImGui::GetIO();
    io.IniFilename = io.LogFilename = nullptr;
}