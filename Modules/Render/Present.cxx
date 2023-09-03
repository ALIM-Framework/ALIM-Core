module;
#include <ctime> // Included due to issue with MSVC & spdlog with localtime_s

#include <imgui_impl_win32.h>
#include <imgui_internal.h>
#include <imstb_textedit.h>
#include <cimgui.h>
#include "ImGuiImpl.hpp"

module Present;

extern LRESULT ImGui_ImplWin32_WndProcHandler(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam);

import PresentUtil;
import LuaEngine;
import Logger;
import Memory;
import Menu;

import <print>;
import <Windows.h>;
import <d3d11.h>;

using namespace ALIM;

// Function Hook Types
//------------------------------------------------------------------------
using tD3D11CreateDeviceAndSwapChain = std::add_pointer_t<HRESULT WINAPI(void* Adapter,
    D3D_DRIVER_TYPE              DriverType,
    HMODULE                      Software,
    UINT                         Flags,
    const void*                  pFeatureLevels,
    UINT                         FeatureLevels,
    UINT                         SDKVersion,
    const DXGI_SWAP_CHAIN_DESC*  SwapChainDesc,
    IDXGISwapChain**             SwapChain,
    ID3D11Device**               Device,
    void*                        FeatureLevel,
    ID3D11DeviceContext**        ImmediateContext)>;

using tD3D11Present  = std::add_pointer_t<HRESULT WINAPI(IDXGISwapChain* pSwapChain,
    UINT SyncInterval,
    UINT Flags)>;

using tResizeBuffers = std::add_pointer_t<HRESULT WINAPI(IDXGISwapChain* pSwapChain,
    UINT BufferCount,
    UINT Width,
    UINT Height,
    DXGI_FORMAT NewFormat,
    UINT SwapChainFlags)>;

// Globals
//------------------------------------------------------------------------
static tD3D11CreateDeviceAndSwapChain oD3D11CreateDeviceAndSwapChain = nullptr;
static tD3D11Present oD3D11Present = nullptr;
static tResizeBuffers oResizeBuffers = nullptr;
static WNDPROC oWindowProcedure = nullptr;

// Utility Functions
//------------------------------------------------------------------------
void CleanupRenderTarget() {
    if (Present::RenderTargetView) {
        Present::RenderTargetView->Release();
        Present::RenderTargetView = nullptr;
    }
}

void CleanupDeviceD3D11() {
    CleanupRenderTarget();

    if (Present::SwapChain) {
        Present::SwapChain->Release();
        Present::SwapChain = nullptr;
    }

    if (Present::Device) {
        Present::Device->Release();
        Present::Device = nullptr;
    }

    if (Present::DeviceContext) {
        Present::DeviceContext->Release();
        Present::DeviceContext = nullptr;
    }
}

void CreateRenderTarget(IDXGISwapChain* pSwapChain) {
    ID3D11Texture2D* pBackBuffer = NULL;
    pSwapChain->GetBuffer(0, __uuidof(ID3D11Texture2D), reinterpret_cast<LPVOID*>(&pBackBuffer));
    if (!pBackBuffer)
        return;

    DXGI_SWAP_CHAIN_DESC SwapChainDesc;
    pSwapChain->GetDesc(&SwapChainDesc);

    Present::Device->CreateRenderTargetView(pBackBuffer, nullptr, &Present::RenderTargetView);
    pBackBuffer->Release();
}

HRESULT GetDeviceAndContextFromSwapChain(IDXGISwapChain* pSwapChain, ID3D11Device** ppDevice, ID3D11DeviceContext** ppContext) {
    const HRESULT ret = pSwapChain->GetDevice(__uuidof(ID3D11Device), reinterpret_cast<PVOID*>(ppDevice));

    if (SUCCEEDED(ret)) {
        (*ppDevice)->GetImmediateContext(ppContext);
    }

    return ret;
}

// Hook Functions
//------------------------------------------------------------------------
HRESULT WINAPI hD3D11Present(IDXGISwapChain* pSwapChain, UINT SyncInterval, UINT Flags) {
    if (!ImGui::GetIO().BackendRendererUserData) {
        if (SUCCEEDED(pSwapChain->GetDevice(IID_PPV_ARGS(&Present::Device)))) {
            Present::Device->GetImmediateContext(&Present::DeviceContext);
            ImGui_ImplDX11_Init(Present::Device, Present::DeviceContext);
        }
    }

    if (!Present::RenderTargetView)
        CreateRenderTarget(pSwapChain);

    if (ImGui::GetCurrentContext() && Present::RenderTargetView) {
        ImGui_ImplDX11_NewFrame();
        ImGui_ImplWin32_NewFrame();
        ImGui::NewFrame();

        {
            Menu::GetInstance().Render();
            LuaEngine::GetInstance().Render();
        }

        ImGui::EndFrame();
        ImGui::Render();
    
        Present::DeviceContext->OMSetRenderTargets(1, &Present::RenderTargetView, nullptr);
        ImGui_ImplDX11_RenderDrawData(ImGui::GetDrawData());
    }

    return oD3D11Present(pSwapChain, SyncInterval, Flags);
}

HRESULT WINAPI hResizeBuffers(IDXGISwapChain* pSwapChain, UINT BufferCount, UINT Width, UINT Height, DXGI_FORMAT NewFormat, UINT SwapChainFlags) {
    CleanupRenderTarget();

    return oResizeBuffers(pSwapChain, BufferCount, Width, Height, NewFormat, SwapChainFlags);
}

HRESULT WINAPI hD3D11CreateDeviceAndSwapChain(
    void* Adapter,
    D3D_DRIVER_TYPE      DriverType,
    HMODULE              Software,
    UINT                 Flags,
    const void* pFeatureLevels,
    UINT                 FeatureLevels,
    UINT                 SDKVersion,
    const DXGI_SWAP_CHAIN_DESC* SwapChainDesc,
    IDXGISwapChain** SwapChain,
    ID3D11Device** Device,
    void* FeatureLevel,
    ID3D11DeviceContext** ImmediateContext
) {
    HRESULT DeviceCreateResult = oD3D11CreateDeviceAndSwapChain(Adapter, DriverType, Software, Flags, pFeatureLevels,
                                                                FeatureLevels, SDKVersion, SwapChainDesc, SwapChain,
                                                                Device, FeatureLevel, ImmediateContext);

    Menu MenuInstance = Menu::GetInstance();
    if (Present::SwapChain) {
        Present::SwapChain->Release();
        Present::SwapChain = nullptr;
    }

    if (!Present::SwapChain) {
        Present::SwapChain = *SwapChain;

        void** VMTPresent = *reinterpret_cast<void***>(*SwapChain);
        auto pD3D11Present = static_cast<tD3D11Present>(VMTPresent[8]);
        auto pResizeBuffers = static_cast<tResizeBuffers>(VMTPresent[13]);

        auto Result = Memory::InstallHook(pD3D11Present, &hD3D11Present, reinterpret_cast<LPVOID*>(&oD3D11Present));
        if (Result.Error != MH_OK) {
            ALIM_CORE_ERROR("Failed hooking D3D11Present! Error: {}", Result.Error);
            return DeviceCreateResult;
        }

        ALIM_CORE_DEBUG("Got D3D11 Present: {:#x}", reinterpret_cast<uintptr_t>(pD3D11Present));

        Result = Memory::InstallHook(pResizeBuffers, &hResizeBuffers, reinterpret_cast<LPVOID*>(&oResizeBuffers));
        if (Result.Error != MH_OK) {
            std::println("Failed hooking ResizeBuffers! Error: {}", Result.Error);
            return DeviceCreateResult;
        }

        ALIM_CORE_DEBUG("Got DXGI Resize Buffers: {:#x}", reinterpret_cast<uintptr_t>(pResizeBuffers));
    }

    return DeviceCreateResult;
}

LRESULT CALLBACK hWindowProcedure(HWND hWnd, UINT Message, WPARAM wParam, LPARAM lParam) {
    Present::WindowHandle = hWnd;
    ALIM::Menu* MenuInstance = &ALIM::Menu::GetInstance();

    if (Message == WM_KEYUP) {
        if (wParam == VK_INSERT) {
            ALIM_CORE_DEBUG("Reloading Lua...");
            LuaEngine::GetInstance().Initialize();
        }
    }

    if (Message == WM_KEYDOWN || Message == WM_KEYUP) {
        const bool IsKeyDown = (Message == WM_KEYDOWN || Message == WM_SYSKEYDOWN);
        const std::size_t VirtualKey = static_cast<std::size_t>(wParam);
        LuaEngine::GetInstance().SendKey(VirtualKey, IsKeyDown);
    }

    if (!Present::CursorEnabled)
        return CallWindowProc(oWindowProcedure, hWnd, Message, wParam, lParam);

    if (ImGui_ImplWin32_WndProcHandler(hWnd, Message, wParam, lParam))
        return true;

    return true;
}

// Present Functions
//------------------------------------------------------------------------
bool Present::Hook(HWND hWnd) {
    HMODULE D3D11 = GetModuleHandleW(L"d3d11.dll");
    if (!D3D11) {
        MessageBoxW(nullptr, L"Failed to get D3D11.dll", L"ALIM-Core Error", MB_OK | MB_ICONERROR);
        return false;
    }

    auto pD3D11CreateDeviceAndSwapChain = reinterpret_cast<tD3D11CreateDeviceAndSwapChain>(GetProcAddress(D3D11, "D3D11CreateDeviceAndSwapChain"));
    if (!pD3D11CreateDeviceAndSwapChain) {
        MessageBoxW(nullptr, L"Failed to get D3D11CreateDeviceAndSwapChain", L"ALIM-Core Error", MB_OK | MB_ICONERROR);
        return false;
    }

    auto Result = Memory::InstallHook(pD3D11CreateDeviceAndSwapChain, &hD3D11CreateDeviceAndSwapChain, reinterpret_cast<LPVOID*>(&oD3D11CreateDeviceAndSwapChain));
    if (Result.Error != MH_OK) {
        MessageBoxW(nullptr, L"Failed to hook D3D11CreateDeviceAndSwapChain", L"ALIM-Core Error", MB_OK | MB_ICONERROR);
        return false;
    }

    oWindowProcedure = reinterpret_cast<WNDPROC>(SetWindowLongPtr(hWnd, GWLP_WNDPROC, reinterpret_cast<LONG_PTR>(hWindowProcedure)));

    return true;
}

void Present::Detach() {
    ImGui_ImplDX11_Shutdown();
    ImGui_ImplWin32_Shutdown();
    ImGui::DestroyContext();

    CleanupDeviceD3D11();
}