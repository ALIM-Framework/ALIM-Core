--------------------------------------------------------------------------------
-- File: imgui_custom.lua
-- Created: 2023-09-04 00:09:35
-- License: http://beamng.com/bCDDL-1.1.txt
--------------------------------------------------------------------------------

local C = ffi.C

return function(M)
    function M.ImVec2(x, y)
        local res = ffi.new("ImVec2")
        res.x = x
        res.y = y
        return res
    end
    
    function M.ImVec2Ptr(x, y)
        local res = ffi.new("ImVec2[1]")
        res[0].x = x or 0
        res[0].y = y or 0
        return res
    end
    
    function M.ImVec3(x, y, z)
        local res = ffi.new("ImVec3")
        res.x = x
        res.y = y
        res.z = z
        return res
    end
    
    function M.ImVec3Ptr(x, y, z)
        local res = ffi.new("ImVec3[1]")
        res[0].x = x
        res[0].y = y
        res[0].z = z
        return res
    end
    
    function M.ImVec4(x, y, z, w)
        local res = ffi.new("ImVec4")
        res.x = x
        res.y = y
        res.z = z
        res.w = w
        return res
    end
    
    function M.ImVec4Ptr(x, y, z, w)
        local res = ffi.new("ImVec4[1]")
        res[0].x = x
        res[0].y = y
        res[0].z = z
        res[0].w = w
        return res
    end

    function M.BoolPtr(x) return ffi.new("bool[1]", x) end
    function M.Bool(x) return ffi.new("bool", x) end

    function M.CharPtr(x) return ffi.new("char[1]", x) end
    function M.Char(x) return ffi.new("char", x) end

    function M.IntPtr(x) return ffi.new("int[1]", x) end
    function M.Int(x) return ffi.new("int", x) end

    function M.FloatPtr(x) return ffi.new("float[1]", x) end
    function M.Float(x) return ffi.new("float", x) end

    function M.DoublePtr(x) return ffi.new("double[1]", x) end
    function M.Double(x) return ffi.new("double", x) end

    function M.ArrayChar(x, val)
        if val then
            return ffi.new("char["..x.."]", val)
        else
            return ffi.new("char[?]", x)
        end
    end

    -- function M.InputText(label, buf, buf_size, flags, callback, user_data)
    --     if not buf_size then buf_size = ffi.sizeof(buf) end
    --     if not flags then flags = 0 end
    
    --     return C.ImGui_InputText(label, buf, buf_size, flags, callback, user_data)
    -- end
    
    -- function M.InputTextMultiline(label, buf, buf_size, size, flags, callback, user_data)
    --     if not buf_size then buf_size = ffi.sizeof(buf) end
    --     if not size then size = M.ImVec2(0,0) end
    --     if not flags then flags = 0 end

    --     return C.ImGui_InputTextMultiline(label, buf, buf_size, size, flags, callback, user_data)
    -- end
end