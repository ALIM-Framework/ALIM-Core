local C = ffi.C

return function(M)
    function M.ImVec2(x, y)
        local res = ffi.new("ImVec2")
        res.x = x
        res.y = y
        return res
    end

    function M.ImVec3(x, y, z)
        local res = ffi.new("ImVec3")
        res.x = x
        res.y = y
        res.z = z
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
end