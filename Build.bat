@echo off
setlocal

set "VCPKG_ROOT=F:\vcpkg"

premake5 --file=Build.lua vs2022
msbuild /p:Configuration="Debug" /p:Platform="Win32" /verbosity:minimal /p:VcpkgEnableManifest=true /p:BuildStlModules=true /p:EnableModules=true /p:BuildStlModules=true "ALIM-Core.sln" /m