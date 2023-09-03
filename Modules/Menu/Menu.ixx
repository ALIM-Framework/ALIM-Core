export module Menu;
import <Windows.h>;

export namespace ALIM {
    class Menu {
    public:
        static Menu& GetInstance() {
            static Menu Instance;
            return Instance;
        }

        void Render();

        void SetEnabled(const bool Enabled) { _Enabled = Enabled; }
        bool GetEnabled() { return _Enabled; }

    private:
        Menu() = default;
        ~Menu() = default;

    private:
        bool _Enabled;
    };
}