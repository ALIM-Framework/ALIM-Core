#include <imgui.h>
#include <imgui_impl_win32.h>

// Imports
//------------------------------------------------------------------------
import Console;
import Logger;
import Window;
import Present;
import Memory;
import LuaEngine;
import Offsets;
import Arguments;
import Cathode;
import Dumper;

import Menu;

import <chrono>;
import <thread>;
import <print>;

import <MinHook.h>;
import <Windows.h>;

// Functions
//------------------------------------------------------------------------
DWORD WINAPI Entry(LPVOID Parameter) {
    MH_Initialize();

    ALIM::Arg::SetCommandLine(GetCommandLineA());
    ALIM::Console::Initialize();
    ALIM::Logger::Initialize();

    { // Check if we should dump offsets
        bool ShouldDump = ALIM::Arg::GetCommandLineOption("dump");
        if (ShouldDump) {
            ALIM::Dumper::Dump();

            MessageBoxW(nullptr, L"Successfully Dumped Offsets! Game will now close...", L"ALIM-Core Dumper", MB_OK | MB_ICONINFORMATION);
            ExitProcess(0);
        }
    }

    ALIM::Logger::Hook();
    ALIM::Cathode::Hook();

    constexpr LPCWSTR WindowTitle = L"Alien: Isolation";
    HWND hWnd = FindWindowW(nullptr, WindowTitle);
    while (!hWnd) {
        std::this_thread::sleep_for(std::chrono::milliseconds(1));
        hWnd = FindWindowW(nullptr, WindowTitle);
    }

    ALIM::Present::Hook(hWnd);
    ALIM::Window::Hook(hWnd);

    { // Initialize ImGui
        IMGUI_CHECKVERSION();

        ImGui::CreateContext();
        ImGui_ImplWin32_Init(hWnd);

        ImGuiIO& io = ImGui::GetIO();
        io.IniFilename = "ALIM/imgui.ini";
    }

    ALIM::LuaEngine::GetInstance().Initialize();
    
    return 0;
}

VOID Cleanup() {
    ALIM::Memory::UninstallAllHooks();
    ALIM::Present::Detach();
    ALIM::Console::Destroy();

    ALIM::Logger::Shutdown();
    MH_Uninitialize();
}

BOOL WINAPI DllMain(
    HINSTANCE Module,
    DWORD Reason,
    LPVOID Reserved)
{
    if (Reason == DLL_PROCESS_ATTACH) {
        DisableThreadLibraryCalls(Module);
        CreateThread(nullptr, 0, Entry, Module, 0, nullptr);
    } else if (Reason == DLL_PROCESS_DETACH) {
        Cleanup();
    }

    return TRUE;
}