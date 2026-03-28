module;
#include <imgui.h>
#include <imgui_impl_win32.h>

module Window;

import Present;
import Memory;
import Logger;
import AI;
import LuaEngine;
import <Windows.h>;
import <type_traits>;

using namespace ALIM;

// Globals
//------------------------------------------------------------------------
static WNDPROC oWindowProcedure = nullptr;

// Window Functions
//------------------------------------------------------------------------
extern LRESULT ImGui_ImplWin32_WndProcHandler(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam);

void Window::EnableCursor(const bool Enabled) noexcept {
    Window::CursorEnabled = Enabled;

    if (Enabled) {
        ClipCursor(NULL);
        ShowCursor(true);
    } else {
        RECT WindowRect;

        GetClientRect(Window::Handle, &WindowRect);
        MapWindowPoints(Window::Handle, NULL, reinterpret_cast<LPPOINT>(&WindowRect), 2);
        ClipCursor(&WindowRect);
        ShowCursor(false);
    }
}

typedef void(__thiscall* tSTDLEVEL_Restart)(DWORD* LevelManager);

LRESULT CALLBACK Window::Procedure(HWND hWnd, UINT Message, WPARAM wParam, LPARAM lParam) {
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
    } else if (Message == WM_MOUSEMOVE) {
        POINT MousePoint;
        GetCursorPos(&MousePoint);
        ScreenToClient(hWnd, &MousePoint);

        ImGuiIO& IO = ImGui::GetIO();
        IO.MousePos.x = static_cast<float>(MousePoint.x);
        IO.MousePos.y = static_cast<float>(MousePoint.y);
    }

    if (!Window::CursorEnabled)
        return CallWindowProc(oWindowProcedure, hWnd, Message, wParam, lParam);

    if (ImGui_ImplWin32_WndProcHandler(hWnd, Message, wParam, lParam))
        return true;

    return true;
}

void Window::Hook(HWND hWnd) {
    oWindowProcedure = reinterpret_cast<WNDPROC>(SetWindowLongPtr(hWnd, GWLP_WNDPROC, reinterpret_cast<LONG_PTR>(Window::Procedure)));
    Window::Handle = hWnd;
}