module Cathode;
import Memory;
import Offsets;
import <unordered_map>;

using namespace ALIM;
using namespace ALIM::Cathode;

namespace Hooks {
    void __fastcall hSTDLEVEL_OpenLevel(Structs::LevelManager* LM) {
        ALIM_CORE_DEBUG("hSTDLEVEL_Open Called!");
        Functions::STDLEVEL::Open(LM);
    }

    void __fastcall hSTDLEVEL_RestartLevel(Structs::LevelManager* LM) {
        ALIM_CORE_DEBUG("hSTDLEVEL_Restart Called!");
        Functions::STDLEVEL::Restart(LM);
    }

    int __fastcall hSTDLEVEL_GetOrMakeNew(Structs::LevelManager* LM, const char* Name) {
        ALIM_CORE_DEBUG("hSTDLEVEL_GetOrMakeNew Called with {}", Name);
        return Functions::STDLEVEL::GetOrMakeNew(LM, Name);
    }
}

void Cathode::Hook() {
    Memory::InstallHook(Offsets::STD_LEVEL__OpenLevel, &Hooks::hSTDLEVEL_OpenLevel, reinterpret_cast<LPVOID*>(&Functions::STDLEVEL::Open));
    Memory::InstallHook(Offsets::STD_LEVEL__Restart, &Hooks::hSTDLEVEL_RestartLevel, reinterpret_cast<LPVOID*>(&Functions::STDLEVEL::Restart));

    // GetOrMakeNew
    //------------------------------------------------------------------------
//    auto GetOrMakeNewSig = Memory::Signature("\x56\x57\x8B\x7C\x24\x0C\x57\x8B\xF1\xE8\xCC\xCC\xCC\xCC\x8B\xC8", "xxxxxxxxxx????xx");
//
//    Result = Memory::InstallHook(GetOrMakeNewSig, &hSTDLEVEL_GetOrMakeNew, reinterpret_cast<LPVOID*>(&CATHODE::Functions::STDLEVEL::GetOrMakeNew));
//    if (Result.Error != MH_OK) {
//        ALIM_CORE_ERROR("Failed hooking \"STDLEVEL_GetOrMakeNew\": {}", MH_StatusToString(static_cast<MH_STATUS>(Result.Error)));
//    }
}