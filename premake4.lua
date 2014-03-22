-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

solution "SoupKitchen"
  configurations { "Debug", "Release" }

  project "SoupKitchen"
    language "C++"
    kind "WindowedApp"

    files { "include/*.h", "source/*.cpp" }
    includedirs { "include" }

    flags { "ExtraWarnings" }

    configuration "Debug"
      defines { "_DEBUG" }
      flags { "Symbols" }

    configuration "Release"
      defines { "NDEBUG" }
      flags { "Optimize" }
