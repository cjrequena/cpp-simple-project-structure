cmake_minimum_required(VERSION 3.14)
project(cpp-simple-project-structure)

set(CMAKE_CXX_STANDARD 17)

include_directories(src)
include_directories(test)

add_executable(
        cpp-simple-project-structure
        src/Main.cpp
)