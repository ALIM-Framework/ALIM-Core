return {
  vcpkg = true,
  triplet = "x86-windows-static",
  debug = {
    links = {
      "minhook.x32d"
    }
  },
  release = {
    "minhook.x32"
  }
}