module;

#include "ALIM.hpp"
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
ALIM_Internal
bool PatternCompare(const char* cData, const char* cPattern, const char* cMask) {
	for (; *cMask; ++cMask, ++cData, ++cPattern) {
		if (*cMask == 'x' && *cData != *cPattern)
			return false;
	}
	return true;
}

ALIM_Internal
void GetModuleInfo() {
    HMODULE Module = GetModuleHandleW(nullptr);

	MODULEINFO ModuleInfo = { nullptr };
	GetModuleInformation(GetCurrentProcess(), Module, &ModuleInfo, sizeof(MODULEINFO));

	BaseAddress = (DWORD32)ModuleInfo.lpBaseOfDll; // reinterpret_cast<DWORD32>(Module);
	ModuleSize = ModuleInfo.SizeOfImage;
}

static void ReplaceAllOccurrences(std::string& input, const std::string& to_replace, const std::string& replacement) {
    size_t pos = 0;
    while ((pos = input.find(to_replace, pos)) != std::string::npos) {
        input.replace(pos, to_replace.length(), replacement);
        pos += replacement.length();
    }
}

// static std::vector<char> PatternToBytes(const char* Pattern) {
//     std::vector<char> Bytes = std::vector<char>{};
//     char* Start = const_cast<char*>(Pattern);
//     char* End = const_cast<char*>(Pattern) + strlen(Pattern);
// 
//     for (char* Current = Start; Current < End; ++Current) {
//         if (*Current == '?') {
//             ++Current;
//             if (*Current == '?')
//                 ++Current;
//             Bytes.push_back('\?');
//         } else {
//             Bytes.push_back(std::strtoul(Current, &Current, 16));
//         }
//     }
// 
//     return Bytes;
// };

// Memory Functions
//------------------------------------------------------------------------
uint32_t Memory::ReadPointer(DWORD32 Address, UINT Offset) {
	const int RelOffset = *(int*)(Address + Offset);
	return Address + RelOffset + sizeof(int) + Offset;
}

uint32_t Memory::FindPattern(const Signature& Sig) {
	std::call_once(HasModuleInfo, GetModuleInfo);
    ALIM_CORE_WARN("Deprecated FindPattern Called");

	for (unsigned __int32 i = 0; i < ModuleSize; i++) {
		if (PatternCompare(reinterpret_cast<char*>(BaseAddress + i), Sig.Pattern, Sig.Mask)) {
			if (Sig.DirectReference)
				return Memory::ReadPointer(BaseAddress + i, 1);
			return BaseAddress + i;
		}
	}

	return 0;
}

// https://www.unknowncheats.me/forum/counterstrike-global-offensive/424928-looking-pattern-scan.html
// From KittenPopo.
// 1 issue, it's very fkn slow..
uint32_t Memory::FindPattern(const std::string& IDAPattern) {
    std::call_once(HasModuleInfo, GetModuleInfo);
    bool Relative = IDAPattern[0] == 'E' && IDAPattern[1] == '8';

	size_t PatternLength = IDAPattern.length();
	for (size_t i = 0; i < ModuleSize - PatternLength; i++) {
		bool Found = true;
		for (size_t j = 0; j < PatternLength; j += 3) {
			// Convert string literal to byte 
			if (IDAPattern[j] == ' ') {
				j -= 2; // Makes the j+=3 work properly in this case
				continue;
			}
 
			// If a wildcard or space, just continue
			if (IDAPattern[j] == '?')
                continue;
 
			long int Lower = std::strtol(&IDAPattern[j], 0, 16);
      
			// If byte does not match the byte from memory
			if ((char)Lower != *(char*)(BaseAddress + i + j / 3)) {
				Found = false;
                break;
			}
		}

		if (Found) {
            if (Relative)
                return Memory::ReadPointer((uintptr_t)BaseAddress + i, 1);

			return (uintptr_t)BaseAddress + i;
		}
	}

	// std::vector<char> PatternBytes = PatternToBytes(IDAPattern.data());
    // 
	// DWORD32 PatternLength = PatternBytes.size();
	// const auto Data = PatternBytes.data();
    // 
	// for (DWORD32 i = 0; i < BaseAddress - PatternLength; i++) {
	// 	bool Found = true;
	// 	for (DWORD32 j = 0; j < PatternLength; j++) {
	// 		char a = '\?';
	// 		char b = *(char*)(BaseAddress + i + j);
	// 		Found &= Data[j] == a || Data[j] == b;
	// 	}
    // 
    //     if (Found) {
    //         if (IDAPattern[0] == 'E' && IDAPattern[1] == '8')
    //             return Memory::ReadPointer(BaseAddress + i, 1);
    //         return BaseAddress + i;
    //     }
	// }
    // 
	// return NULL;
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

    ALIM_CORE_DEBUG("Installed Hook {:#X} -> {:#X}", reinterpret_cast<uint64_t>(Address), reinterpret_cast<uint64_t>(Detour));
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
    std::call_once(HasModuleInfo, GetModuleInfo);
    return BaseAddress;
}