cmake_minimum_required(VERSION 3.30.0)

project(hello_world LANGUAGES C CXX ASM)

include(${SdkRootDirPath}/cmake/extension/mcux.cmake)
# No PROJECT_BOARD_PORT_PATH in project
project(hello_world LANGUAGES C CXX ASM PROJECT_BOARD_PORT_PATH ${board_root}/${board}/<example_category>)
include(${SdkRootDirPath}/CMakeLists.txt)
