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
import SignatureParse; // Temporary?

import Menu;

import <chrono>;
import <thread>;
import <print>;
import <sstream>;

import <MinHook.h>;
import <Windows.h>;

// Functions
//------------------------------------------------------------------------
void WriteNodeToStream(std::stringstream& Stream, const SectionNode& Node) {
    if (Node.Values.size() > 0) {
        for (const auto& Value : Node.Values) {
            Stream << "[" << Node.Name << "] " << Value.Name << ": " << Value.Sig.Token << " " << Value.Sig.Mask << '\n';
        }
    }

    if (Node.Children.size() > 0) {
        for (const auto& ChildNode : Node.Children) {
            WriteNodeToStream(Stream, ChildNode);
        }
    }
}

using tSetCurrentRenderTarget = std::add_pointer_t<__int64 __fastcall(__int64* a1)>;
static tSetCurrentRenderTarget oSetCurrentRenderTarget = nullptr;

__int64 __fastcall hSetCurrentRenderTarget(__int64* a1) {
    ALIM_CORE_DEBUG("hSetCurrentRenderTarget Called!");
    return 0;
}

DWORD WINAPI Entry(LPVOID Parameter) {
    MH_Initialize();

    ALIM::Args::SetCommandLine(GetCommandLineA());
    ALIM::Console::Initialize();
    ALIM::Logger::Initialize();

    { // Check if we should dump offsets
        bool ShouldDump = ALIM::Args::GetCommandLineOption("-dump");
        if (ShouldDump) {
            ALIM_CORE_INFO("Dumping Offsets");

            ALIM::Dumper::Dump();
            MessageBoxW(nullptr, L"Successfully Dumped Offsets! Game will now close...", L"ALIM-Core Dumper", MB_OK | MB_ICONINFORMATION);
            ExitProcess(0);
        }
    }

    ALIM::Logger::Hook();
    ALIM::Cathode::Hook();

    ALIM::Memory::InstallHook(ALIM::Offsets::RENDER::SetCurrentRenderTarget, &hSetCurrentRenderTarget, reinterpret_cast<LPVOID*>(&oSetCurrentRenderTarget));

    constexpr LPCWSTR WindowTitle = L"Alien: Isolation";
    ALIM_CORE_DEBUG("Waiting for window");
    HWND hWnd = FindWindowW(nullptr, WindowTitle);
    while (!hWnd) {
        std::this_thread::sleep_for(std::chrono::milliseconds(1));
        hWnd = FindWindowW(nullptr, WindowTitle);
    }
    ALIM_CORE_DEBUG("Found window title!");

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