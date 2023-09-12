module;

#include <imgui.h>
#include <imgui_impl_win32.h>
#include <imgui_impl_dx11.h>
#include <imgui_internal.h>
#include <imstb_textedit.h>

module Menu;
import Present;
import Logger;
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
}