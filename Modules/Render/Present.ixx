export module Present;

import <Windows.h>;
import <d3d11.h>;
import <Windows.h>;
import <type_traits>;

export namespace ALIM::Present {
    inline IDXGISwapChain* SwapChain;
    inline ID3D11DeviceContext* DeviceContext;
    inline ID3D11Device* Device;
    inline ID3D11RenderTargetView* RenderTargetView;
    inline HWND WindowHandle;
    inline bool CursorEnabled;

    bool Hook(HWND hWnd);
    void Detach();
}