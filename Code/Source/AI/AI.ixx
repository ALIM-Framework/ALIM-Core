export module AI;
import Logger;
import Memory;

import <Windows.h>;

import <type_traits>;
import <print>;
import <string>;

export namespace ALIM::AI {
    // Structures
    //------------------------------------------------------------------------
    namespace Structs {
        struct EntityData {
            void* vtable;          // Offset 0
            DWORD flags;           // Offset 4
            void* state_ref;       // Offset 8
            DWORD instance_guid;   // Offset 12
            DWORD class_guid;      // Offset 16
        };

        struct TemporaryEntityData {
            EntityData base;               // Offset 0
            void* entity_variable_vtable;  // Offset 20
            DWORD unk18;                   // Offset 24
            DWORD unk1C;                   // Offset 28
            DWORD composite_state;         // Offset 32
            DWORD linked_entity_ref;       // Offset 36 (copied via sub_578AF0 into this+0x28)
            WORD type_tag;                 // Offset 44
            WORD pad2E;                    // Offset 46
            double time_value;             // Offset 48
            int runtime_bias;              // Offset 56
            void* unk3C;                   // Offset 60
        };

        struct Entity {
            void* vtable;          // Offset 0
            int ref_count;         // Offset 4
            DWORD unk8;            // Offset 8
            EntityData* data;      // Offset 12
        };

        struct RefObject {
            void* vtable;          // Offset 0
            int ref_count;         // Offset 4
            DWORD unk8;            // Offset 8
            void* ptr;             // Offset 12
        };

        struct RuntimeRefCounted {
            void* vtable;          // Offset 0
            int ref_count;         // Offset 4
        };

        struct ActiveCharactersBucket {
            BYTE gap0[72];
            void** entries;        // Offset 72
            DWORD count;           // Offset 76
        };

        struct Vector3f {
            float x;
            float y;
            float z;
        };

        struct RuntimeCharacter {
            BYTE gap0[80];
            DWORD runtime_id;          // Offset 80
            DWORD u32_84;              // Offset 84
            DWORD u32_88;              // Offset 88
            BYTE gap5C[12];
            void* type_state;          // Offset 100
            BYTE gap68[4];
            Vector3f position;         // Offset 112
            BYTE gap7C[516];
            void* state_object;        // Offset 640
            BYTE gap284[64];
            BYTE u8_708;               // Offset 708
            BYTE gap2C5[52];
            BYTE u8_761;               // Offset 761
            BYTE gap2FA[9];
            BYTE u8_771;               // Offset 771
            BYTE gap304[348];
            WORD u16_1120;             // Offset 1120
            BYTE u8_1122;              // Offset 1122
            BYTE pad463;
            DWORD u32_1124;            // Offset 1124
            DWORD u32_1128;            // Offset 1128
            BYTE gap1134[10308];
            RuntimeRefCounted embedded_refcounted; // Offset 11440
            int i32_11444;             // Offset 11444
        };

        struct ActiveCharacters {
            BYTE gap0[56];
            ActiveCharactersBucket staged_bucket;        // Offset 56
            ActiveCharactersBucket idle_bucket;          // Offset 136
            ActiveCharactersBucket active_npc_bucket;    // Offset 216
            ActiveCharactersBucket bucket_3;             // Offset 296
            void* ptr_376;                               // Offset 376
            ActiveCharactersBucket bucket_4;             // Offset 380
            BYTE gap1B4[72];
            WORD handle_bitset_a_count;                 // Offset 534
            BYTE pad218[2];
            void* handle_bitset_a;                      // Offset 536
            BYTE gap21C[8];
            WORD handle_bitset_b_count;                 // Offset 546
            BYTE pad226[2];
            void* handle_bitset_b;                      // Offset 548
        };

        struct GameGlobals {
            BYTE gap0[8];
            ActiveCharacters* active_characters; // Offset 8
            void* current_player_ref; // Offset 12
        };

        struct EntityContainer {
            BYTE gap0[8];
            int count; // Offset 8
            Entity** entities; // Offset 12
        };

        struct EntityManager {
            BYTE gap0[40];
            EntityContainer* temp_entities; // Offset 40
            BYTE gap2C[24];
            Entity* root_instance; // Offset 68
        };

        struct LevelManager {
            DWORD dword0;
            BYTE gap4[4];
            char char8;
            BYTE gap9[15];
            char char18;
            BYTE gap19[111];
            BYTE byte88;
            BYTE gap89[3];
            DWORD dword8C;
            DWORD dword90;
            DWORD dword94;
            DWORD dword98;
            DWORD dword9C;
            WORD wordA0;
            BYTE gapA2[6];
            DWORD dwordA8;
            DWORD dwordAC;
            WORD wordB0;
            BYTE byteB2;
            BYTE gapB3[5];
            DWORD dwordB8;
            DWORD dwordBC;
            DWORD dwordC0;
            DWORD dwordC4;
            DWORD dwordC8;
            DWORD dwordCC;
            DWORD dwordD0;
            DWORD dwordD4;
            WORD wordD8;
            BYTE gapDA[6];
            DWORD dwordE0;
            DWORD dwordE4;
            BYTE byteE8;
            BYTE gapE9[3];
            DWORD dwordEC;
            DWORD dwordF0;
            DWORD dwordF4;
            DWORD dwordF8;
            DWORD dwordFC;
            DWORD dword100;
            BYTE gap104[8];
            BYTE byte10C;
        };
    }

    namespace Type {
        using tSTDLEVEL_OpenLevel = std::add_pointer_t<void __fastcall(Structs::LevelManager* LM)>;
        using tSTDLEVEL_GetOrMakeNew = std::add_pointer_t<int __fastcall(Structs::LevelManager* LM, const char* Name)>;
        using tSTDLEVEL_Restart = std::add_pointer_t<void __fastcall(Structs::LevelManager* LM)>;

        using tStringTable_Init = std::add_pointer_t<void* __fastcall(void* StringTable)>;

        using tLAYERMANAGER_Render = std::add_pointer_t<int __fastcall(void* self, bool a2)>;
        using tShortGuid_ToString = std::add_pointer_t<const char* __thiscall(void* StringTable, int Index)>;
        using tOffset_From_Hash = std::add_pointer_t<int __thiscall(void* StringTable, DWORD* pHash)>;

        using tEntityManager_Ctor = std::add_pointer_t<void* __thiscall(void* self)>;
        using tEntityVariable_GetTransformMatrix = std::add_pointer_t<float* __thiscall(void* self, float* outMatrix, Structs::Entity** entityHandle)>;
        using tEntityVariable_GetPositionVariableMatrix = std::add_pointer_t<float* __thiscall(void* self, float* outMatrix, Structs::Entity** entityHandle)>;
        using tTemporaryEntity_SyncRuntimeStates = std::add_pointer_t<int __thiscall(void* self, Structs::Entity** entityHandle)>;
        using tHandle_GetTransformMatrixOrDefault = std::add_pointer_t<float* __cdecl(float* outMatrix, Structs::Entity** entityHandle, int, int, int, int, int, int, int, int, int, int, int, int)>;
        using tRuntimeObject_ResolveRef = std::add_pointer_t<void** __thiscall(void* self, void** outRef)>;
        using tRuntimeObject_GetCharacter = std::add_pointer_t<void* __cdecl(void* object)>;
        using tRuntimeObject_GetLogicCharacter = std::add_pointer_t<void* __cdecl(void* object)>;
        using tCompositeInterface_GetActorCharacter = std::add_pointer_t<void* __thiscall(void* self, Structs::Entity** entityHandle)>;
        using tCompositeInterface_GetTacticalPositionMatrix = std::add_pointer_t<float* __thiscall(void* self, float* outMatrix, Structs::Entity** entityHandle)>;
        using tEntityObject_GetHandlePair = std::add_pointer_t<int* __thiscall(void* self, int* outPair)>;
        using tCharacterManager_Get = std::add_pointer_t<void* __cdecl()>;
        using tCharacterManager_FindByHandle = std::add_pointer_t<void* __thiscall(void* self, Structs::Entity** entityHandle)>;
    }

    namespace Functions {
        namespace STDLEVEL {
            Type::tSTDLEVEL_OpenLevel Open;
            Type::tSTDLEVEL_Restart Restart;
            Type::tSTDLEVEL_GetOrMakeNew GetOrMakeNew;
        }

        namespace LAYERMANAGER {
            Type::tLAYERMANAGER_Render Render;
        }

        namespace Entity_Manager {
            Type::tEntityManager_Ctor Ctor;
        }

        namespace Entity_Variable {
            Type::tEntityVariable_GetTransformMatrix GetTransformMatrix;
            Type::tEntityVariable_GetPositionVariableMatrix GetPositionVariableMatrix;
        }

        namespace Temporary_Entity {
            Type::tTemporaryEntity_SyncRuntimeStates SyncRuntimeStates;
        }

        namespace Handle {
            Type::tHandle_GetTransformMatrixOrDefault GetTransformMatrixOrDefault;
        }

        namespace Runtime_Object {
            Type::tRuntimeObject_ResolveRef ResolveRef;
            Type::tRuntimeObject_GetCharacter GetCharacter;
            Type::tRuntimeObject_GetLogicCharacter GetLogicCharacter;
        }

        namespace Composite_Interface {
            Type::tCompositeInterface_GetActorCharacter GetActorCharacter;
            Type::tCompositeInterface_GetTacticalPositionMatrix GetTacticalPositionMatrix;
        }

        namespace Entity_Object {
            Type::tEntityObject_GetHandlePair GetHandlePair;
        }

        namespace Character_Manager {
            Type::tCharacterManager_Get Get;
            Type::tCharacterManager_FindByHandle FindByHandle;
        }

        namespace StringTable {
            Type::tStringTable_Init Init;
            Type::tShortGuid_ToString ShortGuid_ToString;
            Type::tOffset_From_Hash Offset_From_Hash;
        }
    }

    namespace Globals {
        export void* StringTable = 0;
        export void* EntityManager = 0;
        export void* ActiveCharacters = 0;
    }

    // Functions
    //------------------------------------------------------------------------
    void Hook();
}
