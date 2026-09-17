cmake_minimum_required(VERSION 3.30.0)

project(hello_world LANGUAGES C CXX ASM)

set(SdkRootDirPath "mcuxpresso-sdk/mcuxsdk")

add_subdirectory("primary")
add_subdirectory("secondary")
