#
# Copyright 2024 NXP
#
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.22.0)

set(SdkRootDirPath "/home/runner/work/mcuxpresso-sdk-playground/mcuxpresso-sdk-playground/mcuxpresso-sdk/mcuxsdk")
message(STATUS "SdkRootDirPath = ${SdkRootDirPath}")
include(${SdkRootDirPath}/cmake/extension/mcux.cmake)

project(hello_world_primary_core LANGUAGES C CXX ASM PROJECT_BOARD_PORT_PATH ${board_root}/${board}/multicore_examples/hello_world)

include(${SdkRootDirPath}/CMakeLists.txt)
include(
    ${SdkRootDirPath}/examples/multicore_examples/hello_world/primary/../../config.cmake
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

mcux_add_iar_configuration(
    LD "--image_input=${APPLICATION_BINARY_DIR}/../hello_world_secondary_core/iar/core1_image.bin,_core1_image,__core1_image,4 \
        --keep _core1_image"
)

mcux_add_mdk_configuration(
    LD "--library_type=standardlib --keep=*(*core1_code)"
)

mcux_add_include(
    TOOLCHAINS mdk armgcc
    BASE_PATH ${APPLICATION_BINARY_DIR}
    INCLUDES ../hello_world_secondary_core/${CONFIG_TOOLCHAIN}/
)
