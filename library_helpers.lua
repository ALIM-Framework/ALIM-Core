VCPKG_ROOT = path.translate(os.getenv("VCPKG_ROOT"), "/") or "C:/vcpkg"
if not VCPKG_ROOT then
  error("Unable to locate VCPKG, ensure you have it installed and set 'VCPKG_ROOT' in your environment variables")
end

VCPKG_INSTALLED = VCPKG_ROOT .. "/installed/"

-- Library framework
-- Each library is defined in libs/<name>.lua and returns a table with:
--   vcpkg        = true/false    -- if true, automatically adds vcpkg include/lib dirs
--   files        = { ... }       -- source files to compile
--   includedirs  = { ... }       -- include directories
--   links        = { ... }       -- link libraries (shared across configurations)
--   defines      = { ... }       -- preprocessor defines
--   libdirs      = { ... }       -- library search paths
--   no_pch       = true/false    -- disable PCH for the library's source files
--   copy_files   = { ... }       -- files to copy to the output directory (shared across configurations)
--
--   debug        = { links, copy_files, ... }   -- per-configuration overrides
--   release      = { links, copy_files, ... }
--
-- Local library paths are relative to the workspace root.
-- For vcpkg libraries, copy_files paths are relative to the vcpkg bin directory.

-- Applies common fields from a library table (or config-override table).
-- If basedir is provided, it is prepended to files and includedirs entries.
local function apply_lib_fields(lib, basedir)
  if lib.files then
    if basedir then
      local resolved = {}
      for _, f in ipairs(lib.files) do
        table.insert(resolved, basedir .. "/" .. f)
      end
      files(resolved)
    else
      files(lib.files)
    end
  end
  if lib.includedirs then
    if basedir then
      local resolved = {}
      for _, f in ipairs(lib.includedirs) do
        if f == "" then
          table.insert(resolved, basedir)
        else
          table.insert(resolved, basedir .. "/" .. f)
        end
      end
      includedirs(resolved)
    else
      includedirs(lib.includedirs)
    end
  end
  if lib.links then
    links(lib.links)
  end
  if lib.defines then
    defines(lib.defines)
  end
  if lib.libdirs then
    if basedir then
      local resolved = {}
      for _, f in ipairs(lib.libdirs) do
        table.insert(resolved, basedir .. "/" .. f)
      end
      libdirs(resolved)
    else
      libdirs(lib.libdirs)
    end
  end
end

-- Resolves copy_files entries and generates postbuild robocopy commands.
-- Files are grouped by source directory so each directory gets a single robocopy
-- call with all its files, avoiding MSBuild stopping on robocopy's non-zero exit codes.
-- For vcpkg libraries, paths are relative to the vcpkg bin dir.
-- For local libraries, paths are used as-is (relative to workspace root).
local function apply_copy_files(copy_files, is_vcpkg, vcpkg_bin_dir)
  if not copy_files then return end

  -- Group files by source directory
  local groups = {}
  local group_order = {}
  for _, f in ipairs(copy_files) do
    local src = is_vcpkg and (vcpkg_bin_dir .. "/" .. f) or f
    local dir = path.getdirectory(src)
    local name = path.getname(src)
    if not groups[dir] then
      groups[dir] = {}
      table.insert(group_order, dir)
    end
    table.insert(groups[dir], '"' .. name .. '"')
  end

  -- Emit one robocopy command per source directory
  local dst = "%{cfg.targetdir}"
  postbuildcommands { '{MKDIR} "' .. dst .. '"' }
  for _, dir in ipairs(group_order) do
    local file_list = table.concat(groups[dir], " ")
    postbuildcommands {
      'robocopy "' .. dir .. '" "' .. dst .. '" ' .. file_list .. ' /XO /NJH /NJS /NDL /NC /NS & if %errorlevel% gtr 3 (exit /b 1) else (ver >nul)'
    }
  end
end

function link_library(name)
  local lib = dofile("Vendor/" .. name .. ".lua")

  -- Resolve basedir to an absolute path
  local basedir = nil
  if lib.basedir then
    if path.isabsolute(lib.basedir) then
      basedir = lib.basedir
    else
      basedir = _MAIN_SCRIPT_DIR .. "/" .. lib.basedir
    end
  end

  -- vcpkg: automatically add include and lib dirs
  local vcpkg_path = VCPKG_INSTALLED
  if lib.vcpkg then
    if not lib.triplet then
      error("Invalid triplet version for library: " .. name)
    end

    vcpkg_path = vcpkg_path .. lib.triplet .. '/'

    includedirs { vcpkg_path .. "/include" }
    filter "configurations:Debug"
      libdirs { vcpkg_path .. "/debug/lib" }
    filter "configurations:Release"
      libdirs { vcpkg_path .. "/lib" }
    filter {}
  end

  -- Apply shared (non-config-specific) fields
  apply_lib_fields(lib, basedir)

  -- Apply shared copy_files (resolve with basedir for local libs)
  local vcpkg_bin = vcpkg_path .. "/bin"
  local copy_files = lib.copy_files
  if copy_files and basedir and not lib.vcpkg then
    local resolved = {}
    for _, f in ipairs(copy_files) do
      table.insert(resolved, basedir .. "/" .. f)
    end
    copy_files = resolved
  end
  apply_copy_files(copy_files, lib.vcpkg, vcpkg_bin)

  -- Apply per-configuration overrides
  if lib.debug then
    filter "configurations:Debug"
      apply_lib_fields(lib.debug, basedir)
      local debug_copy = lib.debug.copy_files
      if debug_copy and basedir and not lib.vcpkg then
        local resolved = {}
        for _, f in ipairs(debug_copy) do
          table.insert(resolved, basedir .. "/" .. f)
        end
        debug_copy = resolved
      end
      apply_copy_files(debug_copy, lib.vcpkg, vcpkg_path .. "/debug/bin")
    filter {}
  end
  if lib.release then
    filter "configurations:Release"
      apply_lib_fields(lib.release, basedir)
      local release_copy = lib.release.copy_files
      if release_copy and basedir and not lib.vcpkg then
        local resolved = {}
        for _, f in ipairs(release_copy) do
          table.insert(resolved, basedir .. "/" .. f)
        end
        release_copy = resolved
      end
      apply_copy_files(release_copy, lib.vcpkg, vcpkg_path .. "/bin")
    filter {}
  end

  -- Disable PCH for library source files
  if lib.no_pch and lib.files then
    -- Collect unique directories from the resolved source files, made relative
    -- to the current working directory so the filter pattern avoids the
    -- drive letter prefix which premake misparses.
    local dirs = {}
    local seen = {}
    for _, f in ipairs(lib.files) do
      local abs = basedir and (basedir .. "/" .. f) or f
      if abs:match("%.cpp$") or abs:match("%.cc$") or abs:match("%.c$") or abs:match("%*") then
        local dir = path.getrelative(os.getcwd(), path.getdirectory(abs))
        if not seen[dir] then
          seen[dir] = true
          table.insert(dirs, dir)
        end
      end
    end
    for _, dir in ipairs(dirs) do
      filter { "files:" .. dir .. "/**" }
        flags { "NoPCH" }
    end
    filter {}
  end
end