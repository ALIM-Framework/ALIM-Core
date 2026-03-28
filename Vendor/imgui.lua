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
  no_pch = true,
}
