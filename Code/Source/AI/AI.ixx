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
            void* vtable;
            BYTE gap4[8];
            DWORD instance_guid; // Offset 12
            DWORD class_guid;    // Offset 16
        };

        struct Entity {
            void* vtable;
            int ref_count;
            BYTE gap8[4];
            EntityData* data; // Offset 12
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

        namespace StringTable {
            Type::tStringTable_Init Init;
            Type::tShortGuid_ToString ShortGuid_ToString;
            Type::tOffset_From_Hash Offset_From_Hash;
        }
    }

    namespace Globals {
        export void* StringTable = 0;
        export void* EntityManager = 0;
    }

    // Functions
    //------------------------------------------------------------------------
    void Hook();
}