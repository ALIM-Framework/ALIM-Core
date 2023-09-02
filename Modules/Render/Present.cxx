module;
#include <ctime> // Included due to issue with MSVC & spdlog with localtime_s

module Present;

import PresentUtil;
import Logger;
import Memory;
import Menu;

import <print>;
import <Windows.h>;
import <d3d11.h>;
import <imgui.h>;
import <imgui_impl_dx11.h>;
import <imgui_impl_win32.h>;

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

using tSetCursorPos  = std::add_pointer_t<BOOL WINAPI(int x, int y)>;

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

    Menu::GetInstance().Render();
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

        ALIM_CORE_DEBUG("Got D3D11 Present: {:x}", reinterpret_cast<uintptr_t>(pD3D11Present));

        Result = Memory::InstallHook(pResizeBuffers, &hResizeBuffers, reinterpret_cast<LPVOID*>(&oResizeBuffers));
        if (Result.Error != MH_OK) {
            std::println("Failed hooking ResizeBuffers! Error: {}", Result.Error);
            return DeviceCreateResult;
        }

        ALIM_CORE_DEBUG("Got DXGI Resize Buffers: {:x}", reinterpret_cast<uintptr_t>(pResizeBuffers));
    }

    return DeviceCreateResult;
}

LRESULT CALLBACK hWindowProcedure(HWND hWnd, UINT Message, WPARAM wParam, LPARAM lParam)
{
    ALIM::Menu* MenuInstance = &ALIM::Menu::GetInstance();
    bool ShouldDraw = MenuInstance->GetShouldDraw();

    if (Message == WM_KEYUP) {
        if (wParam == VK_F1) {
            ShouldDraw = !ShouldDraw;
            MenuInstance->SetShouldDraw(ShouldDraw);
        }
    }

    if (!ShouldDraw)
        return CallWindowProc(oWindowProcedure, hWnd, Message, wParam, lParam);

    ImGuiIO& io = ImGui::GetIO();
    POINT cursorPos;
    GetCursorPos(&cursorPos);
    ScreenToClient(hWnd, &cursorPos);
    io.MousePos.x = static_cast<float>(cursorPos.x);
    io.MousePos.y = static_cast<float>(cursorPos.y);

    if (Message == WM_KEYDOWN || Message == WM_KEYUP) {
        const bool IsKeyDown = (Message == WM_KEYDOWN || Message == WM_SYSKEYDOWN);
        std::size_t VirtualKey = static_cast<std::size_t>(wParam);

        if (VirtualKey == VK_F4 && (GetAsyncKeyState(VK_MENU) & 0x8000))
            return CallWindowProc(oWindowProcedure, hWnd, Message, wParam, lParam);

        const ImGuiKey KeyPressed = ImGuiUtil::VirtualKeyToImGuiKey(VirtualKey);
        const std::size_t Scancode = static_cast<std::size_t>LOBYTE(HIWORD(lParam));
        if (KeyPressed != ImGuiKey_None)
            io.AddKeyEvent(KeyPressed, IsKeyDown);
        return true;
    } else if (Message == WM_LBUTTONDOWN || Message == WM_LBUTTONUP ||
            Message == WM_RBUTTONDOWN || Message == WM_RBUTTONUP ||
            Message == WM_MBUTTONDOWN || Message == WM_MBUTTONUP ||
            Message == WM_XBUTTONDOWN || Message == WM_XBUTTONUP) {
        int Button = 0;
        if (Message == WM_LBUTTONDOWN || Message == WM_LBUTTONUP) Button = 0;
        if (Message == WM_RBUTTONDOWN || Message == WM_RBUTTONUP) Button = 1;
        if (Message == WM_MBUTTONDOWN || Message == WM_MBUTTONUP) Button = 2;
        if (Message == WM_XBUTTONDOWN || Message == WM_XBUTTONUP) Button = (GET_XBUTTON_WPARAM(wParam) == XBUTTON1) ? 3 : 4;
    
        io.AddMouseButtonEvent(Button, Message == WM_LBUTTONDOWN || Message == WM_RBUTTONDOWN || Message == WM_MBUTTONDOWN || Message == WM_XBUTTONDOWN);
        return true;
    } else if (Message == WM_MOUSEMOVE || Message == WM_NCMOUSEMOVE) {
        return true;
    }

    extern IMGUI_IMPL_API LRESULT ImGui_ImplWin32_WndProcHandler(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam);
    if (ShouldDraw && ImGui_ImplWin32_WndProcHandler(hWnd, Message, wParam, lParam))
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