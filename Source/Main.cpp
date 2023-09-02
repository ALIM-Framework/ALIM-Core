#define SPDLOG_ACTIVE_LEVEL SPDLOG_LEVEL_TRACE
#include <time.h>

// Imports
//------------------------------------------------------------------------
import Console;
import Logger;
import Present;
import Memory;

import Menu;

import <chrono>;
import <thread>;
import <print>;

import <MinHook.h>;
import <Windows.h>;
import <imgui_impl_win32.h>;

// Functions
//------------------------------------------------------------------------
DWORD WINAPI Entry(LPVOID Parameter) {
    ALIM::Console::Initialize();
    ALIM::Log::Initialize();

    MH_Initialize();

    ALIM_CORE_DEBUG("Entry Point");

    constexpr LPCWSTR WindowTitle = L"Alien: Isolation";
    HWND hWnd = FindWindowW(nullptr, WindowTitle);
    while (!hWnd) {
        std::this_thread::sleep_for(std::chrono::milliseconds(1));
        hWnd = FindWindowW(nullptr, WindowTitle);
    }

    ALIM_CORE_DEBUG("HWND: {:#x}", reinterpret_cast<uintptr_t>(hWnd));

    ALIM::Menu::GetInstance().Initialize(hWnd);
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