export module Menu;
import <Windows.h>;

export namespace ALIM {
    class Menu {
    public:
        static Menu& GetInstance() {
            static Menu Instance;
            return Instance;
        }

        void Initialize(HWND hWnd);
        void Render();

        constexpr void SetShouldDraw(const bool ShouldDraw) { _ShowMenu = ShouldDraw; }
        constexpr bool GetShouldDraw() { return _ShowMenu; }

    private:
        Menu() = default;
        ~Menu() = default;

    private:
        bool _ShowMenu;
    };
}