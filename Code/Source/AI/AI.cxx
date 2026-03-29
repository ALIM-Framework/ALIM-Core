module AI;
import Memory;
import Offsets;
import <unordered_map>;

using namespace ALIM;
using namespace ALIM::AI;

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

    int __fastcall hLAYERMANAGER_Render(void* self, bool a2) {
        ALIM_CORE_DEBUG("hLayerManagerRender");
        auto Result = Functions::LAYERMANAGER::Render(self, a2);
        ALIM_CORE_DEBUG("Rendererd");

        return Result;
    }

    void* __fastcall hStringTable_Init(void* StringTable) {
        ALIM_CORE_DEBUG("hStringTable_Init Called!");
        void* Result = Functions::StringTable::Init(StringTable);
        Globals::StringTable = Result;
        ALIM_CORE_DEBUG("StringTable: 0x{:X}", reinterpret_cast<uintptr_t>(Result));
        return Result;
    }

    void* __fastcall hEntityManager_Ctor(void* self) {
        ALIM_CORE_DEBUG("hEntityManager_Ctor Called!");
        void* Result = Functions::Entity_Manager::Ctor(self);
        Globals::EntityManager = Result;
        ALIM_CORE_DEBUG("EntityManager: 0x{:X}", reinterpret_cast<uintptr_t>(Result));
        return Result;
    }
}

void AI::Hook() {
    Functions::StringTable::ShortGuid_ToString = reinterpret_cast<Type::tShortGuid_ToString>(Offsets::StringTable::ShortGuid_ToString);
    Functions::StringTable::Offset_From_Hash = reinterpret_cast<Type::tOffset_From_Hash>(Offsets::StringTable::Offset_From_Hash);
    Functions::LAYERMANAGER::Render = reinterpret_cast<Type::tLAYERMANAGER_Render>(Offsets::UI::LEVELMANAGER::Render);
    Functions::Entity_Variable::GetTransformMatrix = reinterpret_cast<Type::tEntityVariable_GetTransformMatrix>(Offsets::CATHODE::Entity_Variable::GetTransformMatrix);
    Functions::Entity_Variable::GetPositionVariableMatrix = reinterpret_cast<Type::tEntityVariable_GetPositionVariableMatrix>(Offsets::CATHODE::Entity_Variable::GetPositionVariableMatrix);
    Functions::Temporary_Entity::SyncRuntimeStates = reinterpret_cast<Type::tTemporaryEntity_SyncRuntimeStates>(Offsets::CATHODE::Temporary_Entity::SyncRuntimeStates);
    Functions::Handle::GetTransformMatrixOrDefault = reinterpret_cast<Type::tHandle_GetTransformMatrixOrDefault>(Offsets::CATHODE::Handle::GetTransformMatrixOrDefault);
    Functions::Runtime_Object::ResolveRef = reinterpret_cast<Type::tRuntimeObject_ResolveRef>(Offsets::CATHODE::Runtime_Object::ResolveRef);
    Functions::Runtime_Object::GetCharacter = reinterpret_cast<Type::tRuntimeObject_GetCharacter>(Offsets::CATHODE::Runtime_Object::GetCharacter);
    Functions::Runtime_Object::GetLogicCharacter = reinterpret_cast<Type::tRuntimeObject_GetLogicCharacter>(Offsets::CATHODE::Runtime_Object::GetLogicCharacter);
    Functions::Composite_Interface::GetActorCharacter = reinterpret_cast<Type::tCompositeInterface_GetActorCharacter>(Offsets::CATHODE::Composite_Interface::GetActorCharacter);
    Functions::Composite_Interface::GetTacticalPositionMatrix = reinterpret_cast<Type::tCompositeInterface_GetTacticalPositionMatrix>(Offsets::CATHODE::Composite_Interface::GetTacticalPositionMatrix);
    Functions::Entity_Object::GetHandlePair = reinterpret_cast<Type::tEntityObject_GetHandlePair>(Offsets::CATHODE::Entity_Object::GetHandlePair);
    Functions::Character_Manager::Get = reinterpret_cast<Type::tCharacterManager_Get>(Offsets::CATHODE::Character_Manager::Get);
    Functions::Character_Manager::FindByHandle = reinterpret_cast<Type::tCharacterManager_FindByHandle>(Offsets::CATHODE::Character_Manager::FindByHandle);

    Memory::InstallHook(Offsets::STD_LEVEL::Open, &Hooks::hSTDLEVEL_OpenLevel, reinterpret_cast<LPVOID*>(&Functions::STDLEVEL::Open));
    Memory::InstallHook(Offsets::StringTable::New, &Hooks::hStringTable_Init, reinterpret_cast<LPVOID*>(&Functions::StringTable::Init));
    Memory::InstallHook(Offsets::CATHODE::Entity_Manager::Init, &Hooks::hEntityManager_Ctor, reinterpret_cast<LPVOID*>(&Functions::Entity_Manager::Ctor));

    //Memory::InstallHook(Offsets::STD_LEVEL::Restart, &Hooks::hSTDLEVEL_RestartLevel, reinterpret_cast<LPVOID*>(&Functions::STDLEVEL::Restart));
    // Memory::InstallHook(Offsets::UI::LEVELMANAGER::Render, &Hooks::hLAYERMANAGER_Render, reinterpret_cast<LPVOID*>(&Functions::LAYERMANAGER::Render));

    //auto EntityManager_Ctor = Memory::FindPattern(Memory::Signature("\x55\x8B\xEC\x6A\xFF\x68\xCC\xCC\xCC\xCC\x64\xA1\x00\x00\x00\x00\x50\x83\xEC\x08\x53\x56\xA1\xCC\xCC\xCC\xCC\x33\xC5\x50\x8D\x45\//xF4\x64\xA3\x00\x00\x00\x00\x8B\xF1\x89", "xxxxxx????xxxxxxxxxxxxx????xxxxxxxxxxxxxxx"));
    //ALIM_CORE_DEBUG("EntityManager_Ctor: 0x{:X}", EntityManager_Ctor);
    // It finds it just fine, just an issue with how I scan IDA patterns

    // GetOrMakeNew
    //------------------------------------------------------------------------
//    auto GetOrMakeNewSig = Memory::Signature("\x56\x57\x8B\x7C\x24\x0C\x57\x8B\xF1\xE8\xCC\xCC\xCC\xCC\x8B\xC8", "xxxxxxxxxx????xx");
//
//    Result = Memory::InstallHook(GetOrMakeNewSig, &hSTDLEVEL_GetOrMakeNew, reinterpret_cast<LPVOID*>(&CATHODE::Functions::STDLEVEL::GetOrMakeNew));
//    if (Result.Error != MH_OK) {
//        ALIM_CORE_ERROR("Failed hooking \"STDLEVEL_GetOrMakeNew\": {}", MH_StatusToString(static_cast<MH_STATUS>(Result.Error)));
//    }
}
