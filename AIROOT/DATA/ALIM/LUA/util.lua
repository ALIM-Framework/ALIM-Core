local inspect = require("libs/inspect/inspect")

function split(str, delim, nMax)
  local aRecord = {}

  if str_len(str) > 0 then
     nMax = nMax or -1
     local nField, nStart = 1, 1
     local nFirst,nLast = str_find(str, delim, nStart, true)
     while nFirst and nMax ~= 0 do
        aRecord[nField] = str_sub(str, nStart, nFirst-1)
        nField = nField+1
        nStart = nLast+1
        nFirst,nLast = str_find(str, delim, nStart, true)
        nMax = nMax-1
     end
     aRecord[nField] = str_sub(str, nStart)
  end

  return aRecord
end

function dumps(...)
  local arg = {...}
  local narg = table.maxn(arg)
  if narg > 1 then
    local res = {}
    for k=1, narg do
      table.insert(res, inspect(arg[k]))
    end
    return table.concat(res, ', ')
  else
    if narg == 0 then return '' end
    if type(...) == "userdata" then
      local metatable = getmetatable(...)
      if metatable then
        return inspect(metatable)
      end
    end
    return inspect(...)
  end
end