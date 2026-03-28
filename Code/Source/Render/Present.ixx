export module Present;

import <Windows.h>;
import <d3d11.h>;
import <Windows.h>;
import <type_traits>;

constexpr uint32_t RENDER_TARGET_VIEW_COUNT = 2;

export namespace ALIM::Present {
    inline IDXGISwapChain* SwapChain;
    inline ID3D11DeviceContext* DeviceContext;
    inline ID3D11Device* Device;
    inline ID3D11RenderTargetView* RenderTargetViews[RENDER_TARGET_VIEW_COUNT];
    inline ID3D11ShaderResourceView* ShaderResourceView;
    inline ID3D11DepthStencilView* DepthStencilView;

    bool Hook(HWND hWnd);
    void Detach();
}