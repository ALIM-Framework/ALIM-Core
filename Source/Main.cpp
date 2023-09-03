#include <ctime>
#include <imgui.h>
#include <imgui_impl_win32.h>

// Imports
//------------------------------------------------------------------------
import Console;
import Logger;
import Present;
import Memory;
import LuaEngine;

import Menu;

import <chrono>;
import <thread>;
import <print>;

import <MinHook.h>;
import <Windows.h>;

// Functions
//------------------------------------------------------------------------
DWORD WINAPI Entry(LPVOID Parameter) {
    ALIM::Console::Initialize();
    ALIM::Log::Initialize();

    ALIM::LuaEngine::GetInstance().Initialize();
    MH_Initialize();
    ALIM_CORE_DEBUG("Entry Point");

    constexpr LPCWSTR WindowTitle = L"Alien: Isolation";
    HWND hWnd = FindWindowW(nullptr, WindowTitle);
    while (!hWnd) {
        std::this_thread::sleep_for(std::chrono::milliseconds(1));
        hWnd = FindWindowW(nullptr, WindowTitle);
    }

    ALIM_CORE_DEBUG("HWND: {:#x}", reinterpret_cast<uintptr_t>(hWnd));

    { // Initialize ImGui
        IMGUI_CHECKVERSION();

        ImGui::CreateContext();
        ImGui_ImplWin32_Init(hWnd);

        ImGuiIO& io = ImGui::GetIO();
        io.IniFilename = io.LogFilename = nullptr;
    }
    
    ALIM::Present::Hook(hWnd);

    return 0;
}

VOID Cleanup() {
    ALIM::Memory::UninstallAllHooks();
    ALIM::Present::Detach();
    ALIM::Console::Destroy();
    MH_Uninitialize();
}

BOOL WINAPI DllMain(
    HINSTANCE Module,
    DWORD Reason,
    LPVOID Reserved)
{
    if (Reason == DLL_PROCESS_ATTACH) {
        DisableThreadLibraryCalls(Module);
        CreateThread(nullptr, 0, Entry, nullptr, 0, nullptr);
    } else if (Reason == DLL_PROCESS_DETACH) {
        Cleanup();
    }

    return TRUE;
}