include "packages/conandeps.premake5.lua"

workspace "Titan"
   configurations { "Debug", "Release"}
   platforms { "64", "32"}
   location "./projectfiles"
   editorintegration "On"

   project        "Titan"
      kind        "ConsoleApp"
      language    "C++"
      cppdialect  "C++20"
      targetdir   "build/%{cfg.buildcfg}/bin"
      objdir      "build/%{cfg.buildcfg}/obj"
      location    "./projectfiles"
      files { "src/**.cpp", "src/**.h" }
      flags {"LinkTimeOptimization", "MultiProcessorCompile"}
      vectorextensions "AVX"
      enableunitybuild "On"

      filter "configurations:Debug"
         defines { "DEBUG" }
         symbols "On"
         optimize "Debug"
      filter {}

      filter "configurations:Release"
         defines { "NDEBUG" }
         symbols "On"
         optimize "Speed"
      filter {}

      filter "platforms:32"
         architecture "x86"
      filter {}

      filter "platforms:64"
         architecture "amd64"
      filter {}

      filter "system:not windows"
         buildoptions { "-Wall", "-Wextra", "-pedantic", "-pipe", "-fvisibility=hidden", "-Wno-unused-local-typedefs" }
      filter {}

      filter "system:windows"
         openmp "On"
         characterset "MBCS"
         debugformat "c7"
         flags {"NoIncrementalLink"}
         linkoptions {"/IGNORE:4099"}
      filter {}

      filter "toolset:gcc"
         buildoptions { "-fno-strict-aliasing" }
         buildoptions {"-std=c++20"}
      filter {}

      filter "toolset:clang"
         buildoptions { "-Wimplicit-fallthrough", "-Wmove" }
      filter {}

      filter { "system:macosx", "action:gmake" }
         buildoptions { "-fvisibility=hidden" }   
      filter {}

      conan_setup()
      intrinsics   "On"


