export module Memory;
import <string>;
import <string_view>;
import <Windows.h>;
import <MinHook.h>;
import <optional>;

export namespace ALIM::Memory {
    struct Signature {
        explicit Signature(const char* cPattern, const char* cMask, bool bDirectReference = true) :
            Pattern(cPattern), Mask(cMask), DirectReference(bDirectReference) {}

        const char* Pattern;
        const char* Mask;
        bool DirectReference;
    };
    
    struct HookResult {
        explicit HookResult(MH_STATUS eError, uint64_t pAddress) : Error(eError), Address(pAddress) {}

        int Error;
        uint64_t Address;
    };

    [[nodiscard]] inline uint64_t ReadPointer(DWORD64 Address, UINT Offset);
    [[nodiscard]] inline uint64_t FindPattern(const Signature& Sig);

    [[nodiscard]] inline HookResult InstallHook(void* Address, LPVOID Detour, LPVOID* Original, bool Enabled = true);
    [[nodiscard]] inline HookResult InstallHook(const Signature& Sig, LPVOID Detour, LPVOID* Original);

    inline void UninstallAllHooks();
}