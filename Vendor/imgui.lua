return {
  basedir = "Vendor/imgui-1.90",
  files = {
    "*.cpp",
    "*.h",
    "backends/imgui_impl_win32.*",
    "backends/imgui_impl_dx11.*",
  },
  includedirs = {
    "./",
    "backends",
  },
  defines = {
    "IMGUI_DISABLE_OBSOLETE_FUNCTIONS=1"
  },
  no_pch = true,
}
