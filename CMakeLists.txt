cmake_minimum_required(VERSION 3.30.0)

project(hello_world LANGUAGES C CXX ASM)

set(SdkRootDirPath "mcuxpresso-sdk/mcuxsdk")

message(STATUS "SdkRootDirPath = ${SdkRootDirPath}")

include(${SdkRootDirPath}/cmake/extension/mcux.cmake)
include(${SdkRootDirPath}/CMakeLists.txt)
