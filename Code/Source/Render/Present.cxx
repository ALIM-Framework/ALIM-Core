module;
#include <imgui_impl_win32.h>
#include <imgui_impl_dx11.h>
#include <imgui_internal.h>
#include <imstb_textedit.h>

module Present;

import PresentUtil;
import LuaEngine;
import Logger;
import Window;
import Memory;
import Menu;
import Offsets;

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

using tOMSetRenderTargets = std::add_pointer_t<void WINAPI(ID3D11DeviceContext* DeviceContext,
    UINT NumViews,
    ID3D11RenderTargetView * const *ppRenderTargetViews,
    ID3D11DepthStencilView *pDepthStencilView)>;

// Globals
//------------------------------------------------------------------------
static tD3D11CreateDeviceAndSwapChain oD3D11CreateDeviceAndSwapChain = nullptr;
static tD3D11Present oD3D11Present = nullptr;
static tResizeBuffers oResizeBuffers = nullptr;
static tOMSetRenderTargets oOMSetRenderTargets = nullptr;
static bool DX11Initialized = false;

// Utility Functions
//------------------------------------------------------------------------
void CleanupRenderTarget();
void CleanupDeviceD3D11();
void CreateRenderTarget(IDXGISwapChain* pSwapChain);
HRESULT CreateRenderTargetTexture(ID3D11Device* pDevice, IDXGISwapChain* pSwapChain);
HRESULT GetDeviceAndContextFromSwapChain(IDXGISwapChain* pSwapChain, ID3D11Device** ppDevice, ID3D11DeviceContext** ppContext);

static PVOID HookVTableFunction(PDWORD* ppVTable, PVOID Detour, size_t Index, LPVOID* Original) {
    DWORD dwOldProtect;
    if (VirtualProtect(&(*ppVTable)[Index], sizeof(PDWORD), PAGE_EXECUTE_READWRITE, &dwOldProtect)) {
        PVOID pOriginalFunction = reinterpret_cast<PVOID>((*ppVTable)[Index]);
        (*ppVTable)[Index] = reinterpret_cast<DWORD_PTR>(Detour);
        VirtualProtect(&(*ppVTable)[Index], sizeof(PDWORD), dwOldProtect, &dwOldProtect);

        if (Original != nullptr) {
            *Original = pOriginalFunction;
        }
        return pOriginalFunction;
    }

    if (Original != nullptr) {
        *Original = nullptr;
    }
    return nullptr;  // Return nullptr on failure
}

// Hook Functions
//------------------------------------------------------------------------
static UINT gNumViews = 0;

//void WINAPI hOMSetRenderTargets(ID3D11DeviceContext* DeviceContext,
//    UINT NumViews,
//    ID3D11RenderTargetView * const *ppRenderTargetViews,
//    ID3D11DepthStencilView *pDepthStencilView)
//{
//    // if (NumViews >= 2)
//    //     NumViews = 2;
//
//    // if (NumViews >= 3)
//    //     std::memcpy(&Present::RenderTargetViews[1], ppRenderTargetViews[2], sizeof(ID3D11RenderTargetView));
//    // Present::RenderTargetViews[1].SetPrivateData(
//    // 
//    // if (Present::RenderTargetViews[RENDER_TARGET_VIEW_COUNT])
//    //     oOMSetRenderTargets(Present::DeviceContext, RENDER_TARGET_VIEW_COUNT, Present::RenderTargetViews, Present::DepthStencilView);
//    
//    oOMSetRenderTargets(DeviceContext, NumViews, ppRenderTargetViews, pDepthStencilView);
//}

void WINAPI hOMSetRenderTargets(ID3D11DeviceContext* DeviceContext,
    UINT NumViews,
    ID3D11RenderTargetView* const* ppRenderTargetViews,
    ID3D11DepthStencilView* pDepthStencilView) {
    if (!DeviceContext || !ppRenderTargetViews || NumViews == 0) {
        oOMSetRenderTargets(DeviceContext, 0, nullptr, pDepthStencilView);
        return;
    }

    //static float timeOffset = 0.0f;
    //timeOffset += 0.008f; // Slowed down the effect

    //UINT modifiedNumViews = min(NumViews, D3D11_SIMULTANEOUS_RENDER_TARGET_COUNT);
    //ID3D11RenderTargetView* modifiedTargets[D3D11_SIMULTANEOUS_RENDER_TARGET_COUNT] = { nullptr };

    //// Copy targets with occasional gentle swap
    //for (UINT i = 0; i < modifiedNumViews; i++) {
    //    if (!ppRenderTargetViews[i]) {
    //        continue;
    //    }

    //    modifiedTargets[i] = ppRenderTargetViews[i];

    //    // Only swap every 2 seconds and only the first two targets
    //    if (i == 0 && timeOffset - (int)timeOffset > 0.75f &&
    //        modifiedNumViews > 1 && ppRenderTargetViews[1]) {
    //        modifiedTargets[0] = ppRenderTargetViews[1];
    //        modifiedTargets[1] = ppRenderTargetViews[0];
    //        i++; // Skip next
    //    }
    //}

    oOMSetRenderTargets(DeviceContext, NumViews, ppRenderTargetViews, pDepthStencilView);
}

using tSetRenderTargets = std::add_pointer_t<int __cdecl(int a1, unsigned __int16 a2, unsigned __int16* a3, unsigned int a4)>;
static tSetRenderTargets oSetRenderTargets = nullptr;

int __cdecl hSetRenderTargets(int a1, unsigned __int16 a2, unsigned __int16* a3, unsigned int a4) {
    if (!oOMSetRenderTargets)
        return 0;

    // Hooking this just makes the game black because there is no render target :D
    // I need to redirect this to mine
    //ALIM_CORE_DEBUG("SetRenderTargets Called! {}", a2);

    return oSetRenderTargets(a1, a2, a3, a4);
}

using tDX11_GetNativeRenderTarget = std::add_pointer_t<int __cdecl(int a1, unsigned __int16 a2)>;
static tDX11_GetNativeRenderTarget oDX11_GetNativeRenderTarget = nullptr;

int __cdecl hDX11_GetNativeRenderTarget(int a1, unsigned __int16 a2) {
    //ALIM_CORE_DEBUG("DX11_GetNativeRenderTarget Called!");
    // Doesn't seem to do anything if I just return 0 and do nothing, hmm...

    // if (!Present::ShaderResourceView)
    //     return oDX11_GetNativeRenderTarget(a1, a2);
    // return reinterpret_cast<int>(Present::RenderTargetViews[1]);
     return oDX11_GetNativeRenderTarget(a1, a2);
    //return 0;
}

HRESULT WINAPI hD3D11Present(IDXGISwapChain* pSwapChain, UINT SyncInterval, UINT Flags) {
    if (!ImGui::GetIO().BackendRendererUserData) {
        if (SUCCEEDED(pSwapChain->GetDevice(IID_PPV_ARGS(&Present::Device)))) {
            Present::Device->GetImmediateContext(&Present::DeviceContext);

            void** VTable = *reinterpret_cast<void***>(Present::DeviceContext);
            tOMSetRenderTargets pOMSetRenderTargets = reinterpret_cast<tOMSetRenderTargets>(VTable[33]);
    
             { // OMSetRenderTargets
                 Memory::HookResult Result = Memory::InstallHook(pOMSetRenderTargets, &hOMSetRenderTargets, reinterpret_cast<LPVOID*>(&oOMSetRenderTargets));
                 if (Result.Error != MH_OK) {
                     std::println("Failed hooking OMSetRenderTargets! Error: {}", Result.Error);
                 }
     
                 ALIM_CORE_DEBUG("Got OMSetRenderTargets: {:#x}", reinterpret_cast<uintptr_t>(pOMSetRenderTargets));
                 ALIM_CORE_DEBUG("{:#x}", Memory::GetBase() - reinterpret_cast<uintptr_t>(pOMSetRenderTargets));
             }

            CreateRenderTarget(pSwapChain);
            ImGui_ImplDX11_Init(Present::Device, Present::DeviceContext);
            DX11Initialized = true;

            ALIM_CORE_DEBUG("Set renderer backend to DX11");
        }
    }

    if (ImGui::GetCurrentContext()) {
        {
            FLOAT Color[4] = { 1.0, 0.0, 0.0, 1.0 };
    
             Present::DeviceContext->ClearRenderTargetView(Present::RenderTargetViews[1], Color);
             Present::DeviceContext->ClearDepthStencilView(Present::DepthStencilView, D3D11_CLEAR_DEPTH, 1.0, 0);
    
            oOMSetRenderTargets(Present::DeviceContext, RENDER_TARGET_VIEW_COUNT, Present::RenderTargetViews, Present::DepthStencilView);
        }

        ImGui_ImplDX11_NewFrame();
        ImGui_ImplWin32_NewFrame();
        ImGui::NewFrame();

        ImGui::SetNextWindowSize(ImVec2(200, 200), ImGuiCond_Once);

        {
            Menu::GetInstance().Render();
            LuaEngine::GetInstance().Render();
        }

        //if (ImGui::Begin("Game")) {
        //    ImGui::Image((void*)Present::ShaderResourceView, ImVec2(200, 200));
        //} ImGui::End();

        ImGui::EndFrame();
        ImGui::Render();
        ImGui_ImplDX11_RenderDrawData(ImGui::GetDrawData());
    }

    return oD3D11Present(pSwapChain, SyncInterval, Flags);
}

HRESULT WINAPI hResizeBuffers(IDXGISwapChain* pSwapChain, UINT BufferCount, UINT Width, UINT Height, DXGI_FORMAT NewFormat, UINT SwapChainFlags) {
    CleanupRenderTarget();
    
    LuaEngine::GetInstance().OnResize(Width, Height);
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
    if (Present::SwapChain) {
        Present::SwapChain->Release();
        Present::SwapChain = nullptr;
    }

    if (!Present::SwapChain) {
        Present::SwapChain = *SwapChain;

        void** SwapChainVTable = *reinterpret_cast<void***>(*SwapChain);
        auto pD3D11Present = static_cast<tD3D11Present>(SwapChainVTable[8]);
        auto pResizeBuffers = static_cast<tResizeBuffers>(SwapChainVTable[13]);

        Memory::HookResult Result{};

        ALIM::Memory::InstallHook(ALIM::Offsets::RENDER::GFX::SetRenderTargets, &hSetRenderTargets, reinterpret_cast<LPVOID*>(&oSetRenderTargets));
        ALIM::Memory::InstallHook(ALIM::Offsets::RENDER::GFX::DX11_GetNativeRenderTarget, &hDX11_GetNativeRenderTarget, reinterpret_cast<LPVOID*>(&oDX11_GetNativeRenderTarget));

         { // Present
             Result = Memory::InstallHook(pD3D11Present, &hD3D11Present, reinterpret_cast<LPVOID*>(&oD3D11Present));
             if (Result.Error != MH_OK) {
                 ALIM_CORE_ERROR("Failed hooking D3D11Present! Error: {}", Result.Error);
                 return DeviceCreateResult;
             }
 
             ALIM_CORE_DEBUG("Got D3D11 Present: {:#x}", reinterpret_cast<uintptr_t>(pD3D11Present));
         }

         { // Resize
             Result = Memory::InstallHook(pResizeBuffers, &hResizeBuffers, reinterpret_cast<LPVOID*>(&oResizeBuffers));
             if (Result.Error != MH_OK) {
                 std::println("Failed hooking ResizeBuffers! Error: {}", Result.Error);
                 return DeviceCreateResult;
             }
 
             ALIM_CORE_DEBUG("Got DXGI Resize Buffers: {:#x}", reinterpret_cast<uintptr_t>(pResizeBuffers));
         }
    }

    return DeviceCreateResult;
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

     ALIM_CORE_INFO("Present::Hook Successful");

    return true;
}

void Present::Detach() {
    if (!DX11Initialized)
        return;
    
    ImGui_ImplDX11_Shutdown();
    ImGui_ImplWin32_Shutdown();
    ImGui::DestroyContext();
    CleanupDeviceD3D11();
}

void CleanupRenderTarget() {
    for (size_t i = 0; i < RENDER_TARGET_VIEW_COUNT; ++i) {
        if (Present::RenderTargetViews[i]) {
            Present::RenderTargetViews[i]->Release();
            Present::RenderTargetViews[i] = nullptr;
        }
    }
}

void CleanupDeviceD3D11() {
    if (!DX11Initialized)
        return;

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
    SwapChainDesc.BufferDesc.Width = 800;
    SwapChainDesc.BufferDesc.Height = 600;

    pSwapChain->GetDesc(&SwapChainDesc);
    HRESULT hr = S_OK;

    Present::Device->CreateRenderTargetView(pBackBuffer, nullptr, &Present::RenderTargetViews[0]);

    ID3D11Texture2D* GameRenderTexture = nullptr;
    
    { // Create Texture
        D3D11_TEXTURE2D_DESC TextureDesc = { 0 };
        TextureDesc.Width = 800;
        TextureDesc.Height = 600;
        TextureDesc.MipLevels = 1;
        TextureDesc.ArraySize = 1;
        TextureDesc.Format = DXGI_FORMAT_R8G8B8A8_UNORM;
        TextureDesc.SampleDesc.Count = 1;
        TextureDesc.Usage = D3D11_USAGE_DEFAULT;
        TextureDesc.BindFlags = D3D11_BIND_RENDER_TARGET | D3D11_BIND_SHADER_RESOURCE;
        TextureDesc.CPUAccessFlags = 0;
        TextureDesc.MiscFlags = 0;
    
        hr = Present::Device->CreateTexture2D(&TextureDesc, nullptr, &GameRenderTexture);
        if (FAILED(hr)) {
            ALIM_CORE_ERROR("CreateTexture2D Failed: {}", hr);
            pBackBuffer->Release();
            return;
        }
    }

    { // Render Target View
        D3D11_RENDER_TARGET_VIEW_DESC RTV = { 0 };
        ZeroMemory(&RTV, sizeof(D3D11_RENDER_TARGET_VIEW_DESC));

        RTV.Format = DXGI_FORMAT_R8G8B8A8_UNORM;
        RTV.ViewDimension = D3D11_RTV_DIMENSION_TEXTURE2D;
        RTV.Texture2D.MipSlice = 0;

        Present::DeviceContext->CopyResource(GameRenderTexture, pBackBuffer);
    
        hr = Present::Device->CreateRenderTargetView(GameRenderTexture, &RTV, &Present::RenderTargetViews[1]);
        if (FAILED(hr)) {
            DWORD ErrorCode = HRESULT_FROM_WIN32(HRESULT_CODE(hr));
            ALIM_CORE_ERROR("CreateRenderTargetView Failed: 0x{:X}", ErrorCode);
            pBackBuffer->Release();
            return;
        } else {
            ALIM_CORE_DEBUG("Created Render Target View");
        }
    }
    
    {
        D3D11_SHADER_RESOURCE_VIEW_DESC SRV;
        ZeroMemory(&SRV, sizeof(D3D11_SHADER_RESOURCE_VIEW_DESC));

        SRV.Format = DXGI_FORMAT_R8G8B8A8_UNORM;
        SRV.ViewDimension = D3D11_SRV_DIMENSION_TEXTURE2D;
        SRV.Texture2D.MipLevels = 1;
        SRV.Texture2D.MostDetailedMip = 0;
    
        hr = Present::Device->CreateShaderResourceView(GameRenderTexture, &SRV, &Present::ShaderResourceView);
        if (FAILED(hr)) {
            DWORD ErrorCode = HRESULT_FROM_WIN32(HRESULT_CODE(hr));
            ALIM_CORE_ERROR("CreateShaderResourceView Failed: 0x{:X}", ErrorCode);
            pBackBuffer->Release();
            return;
        } else {
            ALIM_CORE_DEBUG("Created Shader Resource View for ImGui");
        }
    }
    
    { // Depth Stencil
        // Create depth stencil texture
        D3D11_TEXTURE2D_DESC descDepth;
        ZeroMemory(&descDepth, sizeof(descDepth));
        descDepth.Width = 800;
        descDepth.Height = 600;
        descDepth.MipLevels = 1;
        descDepth.ArraySize = 1;
        descDepth.Format = DXGI_FORMAT_D32_FLOAT;
        descDepth.SampleDesc.Count = 1;
        descDepth.SampleDesc.Quality = 0;
        descDepth.Usage = D3D11_USAGE_DEFAULT;
        descDepth.BindFlags = D3D11_BIND_DEPTH_STENCIL;
        descDepth.CPUAccessFlags = 0;
        descDepth.MiscFlags = 0;
        
        ID3D11Texture2D* pDepthStencil = NULL;
        hr = Present::Device->CreateTexture2D(&descDepth, NULL, &pDepthStencil);
        if (FAILED(hr)) {
            ALIM_CORE_ERROR("CreateTexture2D Failed: {}", hr);
            return;
        }
        
        // Create the depth stencil view
        D3D11_DEPTH_STENCIL_VIEW_DESC descDSV;
        ZeroMemory(&descDSV, sizeof(descDSV));
        descDSV.Format = descDepth.Format;
        descDSV.ViewDimension = D3D11_DSV_DIMENSION_TEXTURE2D;
        descDSV.Texture2D.MipSlice = 0;
        
        hr = Present::Device->CreateDepthStencilView(pDepthStencil, &descDSV, &Present::DepthStencilView);
        if (FAILED(hr)) {
            ALIM_CORE_ERROR("CreateDepthStencilView Failed: {}", hr);
            return;
        }
    }
    
    GameRenderTexture->Release();
    pBackBuffer->Release();
}

HRESULT GetDeviceAndContextFromSwapChain(IDXGISwapChain* pSwapChain, ID3D11Device** ppDevice, ID3D11DeviceContext** ppContext) {
    const HRESULT ret = pSwapChain->GetDevice(__uuidof(ID3D11Device), reinterpret_cast<PVOID*>(ppDevice));

    if (SUCCEEDED(ret)) {
        (*ppDevice)->GetImmediateContext(ppContext);
    }

    return ret;
}