module Console;

import <Windows.h>;
import <cstdio>;

using namespace ALIM;

FILE* CF = nullptr;

void Console::Initialize() {
    if (!AllocConsole()) {
        MessageBoxW(nullptr, L"Failed to create console", L"ALIM-Core Error", MB_OK | MB_ICONERROR);
        return;
    }

    freopen_s(&CF, "CONOUT$", "w", stdout);
    freopen_s(&CF, "CONOUT$", "w", stderr);

    SetConsoleTitleW(L"ALIM-Core Debug Console");

    HWND ConsoleWindow = GetConsoleWindow();

    SetWindowLongPtr(ConsoleWindow, GWL_STYLE, GetWindowLongPtr(ConsoleWindow, GWL_STYLE) & ~WS_MAXIMIZEBOX & ~WS_SIZEBOX);

    HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
    DWORD dwMode = 0;
    GetConsoleMode(hConsole, reinterpret_cast<LPDWORD>(&dwMode));
    dwMode |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
    SetConsoleMode(hConsole, dwMode);
}

void Console::Destroy() {
    if (!CF) {
        FreeConsole();
        return;
    }

    std::fclose(stderr);
    std::fclose(stdout);
    std::fclose(CF);
    FreeConsole();
}