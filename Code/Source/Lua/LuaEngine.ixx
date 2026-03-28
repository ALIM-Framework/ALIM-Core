module;

#include <sol/sol.hpp>

export module LuaEngine;
import <string_view>;
import Singleton;

export namespace ALIM {
    class LuaEngine : public Singleton<LuaEngine> {
    public:
        LuaEngine();
        ~LuaEngine();

        void Initialize() noexcept;

        void OnResize(const uint32_t width, const uint32_t height) noexcept;
        void Render() noexcept;
        void SendKey(const std::size_t VirtualKey, const bool KeyDown) noexcept;
        void AddLog(std::string_view Time, std::string_view LT, std::string_view Level, std::string_view Message);

        template <typename... Ret, typename... Args>
        decltype(auto) CallEvent(std::string_view name, Args&&... args);

    private:
        std::unique_ptr<sol::state> m_LuaState;
        bool m_bInitialized;
    };
}