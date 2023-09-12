module;

#include <Windows.h>
#include <Psapi.h>

module Memory;
import Logger;

import <mutex>;
import <print>;
import <vector>;
import <optional>;
import <MinHook.h>;

using namespace ALIM;

// Globals
//------------------------------------------------------------------------
static DWORD32 BaseAddress;
static DWORD ModuleSize;

static std::once_flag HasModuleInfo;
static std::vector<uint64_t> InstalledHooks;

std::unordered_map<std::string_view, uintptr_t> Offsets;

// Internal Functions
//------------------------------------------------------------------------
bool PatternCompare(const char* cData, const char* cPattern, const char* cMask) {
	for (; *cMask; ++cMask, ++cData, ++cPattern) {
		if (*cMask == 'x' && *cData != *cPattern)
			return false;
	}
	return true;
}

void GetModuleInfo() {
    HMODULE Module = GetModuleHandleW(nullptr);

	MODULEINFO ModuleInfo = { nullptr };
	GetModuleInformation(GetCurrentProcess(), Module, &ModuleInfo, sizeof(MODULEINFO));

	BaseAddress = reinterpret_cast<DWORD32>(Module);
	ModuleSize = ModuleInfo.SizeOfImage;
}

// Memory Functions
//------------------------------------------------------------------------
uint32_t Memory::ReadPointer(DWORD32 Address, UINT Offset) {
	const int RelOffset = *(int*)(Address + Offset);
	return Address + RelOffset + sizeof(int) + Offset;
}

uint32_t Memory::FindPattern(const Signature& Sig) {
	std::call_once(HasModuleInfo, GetModuleInfo);

	for (unsigned __int32 i = 0; i < ModuleSize; i++) {
		if (PatternCompare(reinterpret_cast<char*>(BaseAddress + i), Sig.Pattern, Sig.Mask)) {
			if (Sig.DirectReference)
				return Memory::ReadPointer(BaseAddress + i, 1);
			return BaseAddress + i;
		}
	}

	return 0;
}

Memory::HookResult Memory::InstallHook(void* Address, LPVOID Detour, LPVOID* Original, bool Enabled) {
    MH_STATUS Status = MH_CreateHook(Address, Detour, Original);
    if (Status != MH_OK) {
        ALIM_CORE_ERROR("Failed Hooking {}: {}", Address, MH_StatusToString(static_cast<MH_STATUS>(Status)));
        return Memory::HookResult(Status, 0);
    }

    if (Enabled) {
        Status = MH_EnableHook(Address);
        if (Status != MH_OK) {
            ALIM_CORE_ERROR("Failed Hooking {:#x}: {}", Address, MH_StatusToString(static_cast<MH_STATUS>(Status)));
            return Memory::HookResult(Status, 0);
        }
    }

    InstalledHooks.emplace_back(reinterpret_cast<uint64_t>(Address));

    ALIM_CORE_DEBUG("Installed Hook {:#x} -> {:#x}", reinterpret_cast<uint64_t>(Address), reinterpret_cast<uint64_t>(Detour));
    return Memory::HookResult(MH_OK, reinterpret_cast<uint64_t>(Address));
}

Memory::HookResult Memory::InstallHook(const Signature& Sig, LPVOID Detour, LPVOID* Original) {
    const uint64_t HookAddress = Memory::FindPattern(Sig);

    if (!HookAddress) {
        ALIM_CORE_ERROR("InstallHook(SIG): Invalid HookAddres: {}", HookAddress);
        return Memory::HookResult(MH_UNKNOWN, 0);
    }

    return InstallHook(reinterpret_cast<void*>(HookAddress), Detour, Original);
}

void Memory::UninstallAllHooks() {
    MH_STATUS Status = MH_OK;
    for (const auto& Hook : InstalledHooks) {
        Status = MH_RemoveHook(reinterpret_cast<LPVOID>(Hook));
        if (Status != MH_OK)
            ALIM_CORE_ERROR("Failed Uninstalling Hook: {:x}", Hook);
    }
}

uint32_t Memory::GetBase() {
    return BaseAddress;
}