-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

solution "SoupKitchen"
  configurations { "Debug", "Release" }

  project "SoupKitchen"
    language "C++"
    kind "WindowedApp"

    files { "include/*.h", "source/*.cpp" }
    includedirs { "include", "SFML/include" }

    if os.is("linux") then
      libdirs { "/opt/SFML/lib" }
    else
      libdirs { "SFML/windows-32" }
    end

    links { "sfml-graphics", "sfml-window", "sfml-system", "GLEW" }

    flags { "ExtraWarnings" }

    configuration "Debug"
      defines { "_DEBUG" }
      flags { "Symbols" }

    configuration "Release"
      defines { "NDEBUG" }
      flags { "Optimize" }
