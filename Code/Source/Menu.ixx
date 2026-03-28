export module Menu;
import <Windows.h>;
import Singleton;

export namespace ALIM {
    class Menu : public Singleton<Menu> {
    public:
        Menu() {}
        ~Menu() {}

        void Render();

        void SetEnabled(const bool Enabled) { _Enabled = Enabled; }
        bool GetEnabled() { return _Enabled; }

    private:
        bool _Enabled;
    };
}