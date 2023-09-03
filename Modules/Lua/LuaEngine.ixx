module;

#define SOL_LUAJIT 1
#include <sol/sol.hpp>

export module LuaEngine;
import Singleton;

export namespace ALIM {
    class LuaEngine {
    public:
        static LuaEngine& GetInstance() {
            static LuaEngine Instance;
            return Instance;
        }

        void Initialize();
        void Render();
        void SendKey(const std::size_t VirtualKey, const bool KeyDown);

    private:
        std::unique_ptr<sol::state> lua;
    };
}