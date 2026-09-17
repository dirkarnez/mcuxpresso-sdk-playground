#
# Copyright 2024-2025 NXP
#
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.22.0)

set(SdkRootDirPath "$ENV{MCUXPRESSO_SDK_DIR}")
message(STATUS "SdkRootDirPath = ${SdkRootDirPath}")
include(${SdkRootDirPath}/cmake/extension/mcux.cmake)

project(hello_world_secondary_core LANGUAGES C CXX ASM PROJECT_BOARD_PORT_PATH ${board_root}/${board}/multicore_examples/hello_world)

include(
    ${SdkRootDirPath}/CMakeLists.txt
)

include(
    ${SdkRootDirPath}/examples/multicore_examples/hello_world/secondary/../../config.cmake
)

include(
    ${SdkRootDirPath}/${board_root}/${board}/multicore_examples/hello_world/${core_id}/reconfig.cmake OPTIONAL
)

mcux_add_source(
    BASE_PATH ${CMAKE_CURRENT_LIST_DIR}
    SOURCES main.c
)

mcux_add_include(
    BASE_PATH ${CMAKE_CURRENT_LIST_DIR}
    INCLUDES .
)

mcux_add_configuration(
    CC "-DMCMGR_HANDLE_EXCEPTIONS=1 -D__SEMIHOST_HARDFAULT_DISABLE=1"
)

mcux_add_mdk_configuration(
    LD "--library_type=standardlib"
)

mcux_convert_binary(
    TOOLCHAINS armgcc mdk iar
    BINARY ${APPLICATION_BINARY_DIR}/${CONFIG_TOOLCHAIN}/core1_image.bin
)

