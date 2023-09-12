export module Window;

import <Windows.h>;

export namespace ALIM::Window {
    void EnableCursor(const bool Enabled) noexcept;
    LRESULT CALLBACK Procedure(HWND hWnd, UINT Message, WPARAM wParam, LPARAM lParam);

    void Hook(HWND hWnd);

    inline bool CursorEnabled;
    inline HWND Handle;
}