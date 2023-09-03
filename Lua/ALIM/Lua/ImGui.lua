--------------------------------------------------------------------------------
-- File: ImGui.lua
-- Created: 2023-09-03 16:34:40
-- License: http://beamng.com/bCDDL-1.1.txt
--------------------------------------------------------------------------------

local ffi = require('ffi')

local function readFile(filename)
    local f = io.open(filename, 'r')
    if not f then return nil end

    local contents = f:read("*all")
    f:close()
    return contents
end

ffi.cdef([[
    typedef struct ImVector {
        int Size;
        int Capacity;
        void* Data;
    } ImVector;

    typedef struct ImVec2 {
        float x;
        float y;
    } ImVec2;

    typedef struct ImVec3 {
        float x;
        float y;
        float z;
    } ImVec2;

    typedef struct ImVec4 {
        float x;
        float y;
        float z;
        float w;
    } ImVec4;
]])
ffi.cdef(readFile('ALIM/Lua/ImGui_Generated.h'))

local M = {}
M.ctx = nil

require("ALIM/Lua/ImGui_Generated")(M)
require("ALIM/Lua/ImGui_Custom")(M)

return M