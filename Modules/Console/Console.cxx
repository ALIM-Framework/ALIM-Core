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
}

void Console::Destroy() {
    if (!CF)
        return;

    std::fclose(stderr);
    std::fclose(stdout);
    std::fclose(CF);
    FreeConsole();
}