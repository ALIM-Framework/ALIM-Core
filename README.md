## Building
### Dependencies:
- [VCPKG](https://vcpkg.io/en/)
  - vcpkg install sol2:x86-windows-static
  - vcpkg install luajit:x86-windows-static
  - vcpkg install minhook:x86-windows-static
  - vcpkg install spdlog:x86-windows-static
- [Premake](https://premake.github.io/) (5.0.0-beta3+)
- C++23
- MSVC Comiler

Note: This is a somewhat old project, currently cleaning it up.  
I started this to try out C++20 modules, there were some issues at the start like having to do hacky things in Premake and also a MSVC compiler crash, but it seems to be somewhat better now.