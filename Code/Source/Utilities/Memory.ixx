export module Memory;
import <string>;
import <string_view>;
import <Windows.h>;
import <MinHook.h>;
import <optional>;
import <unordered_map>;

export namespace ALIM::Memory {
    // Structures
    //------------------------------------------------------------------------
    struct Signature {
        explicit constexpr Signature(const char* cPattern, const char* cMask, bool bDirectReference = false) :
        Pattern(cPattern), Mask(cMask), DirectReference(bDirectReference) {}

        const char* Pattern;
        const char* Mask;
        bool DirectReference;
    };
    
    struct HookResult {
        HookResult() = default;
        explicit HookResult(MH_STATUS eError, uint32_t pAddress) : Error(eError), Address(pAddress) {}

        int Error;
        uint32_t Address;
    };

    // Functions
    //------------------------------------------------------------------------
    [[nodiscard]] inline uint32_t ReadPointer(DWORD32 Address, UINT Offset);
    [[nodiscard]] inline uint32_t FindPattern(const Signature& Sig);
    [[nodiscard]] inline uint32_t FindPattern(const std::string& IDAPattern);

    inline HookResult InstallHook(void* Address, LPVOID Detour, LPVOID* Original = nullptr, bool Enabled = true);

    template<typename T, typename F>
    inline HookResult InstallHook(T Address, LPVOID Detour, F* Original = nullptr, bool Enabled = true) {
        return Memory::InstallHook(reinterpret_cast<void*>(Address), Detour, reinterpret_cast<LPVOID*>(Original), Enabled);
    }

    inline HookResult InstallHook(const Signature& Sig, LPVOID Detour, LPVOID* Original = nullptr);

    [[nodiscard]] inline uint32_t GetBase();

    void UninstallAllHooks();
}