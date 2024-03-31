# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.
cmake_minimum_required(VERSION 3.3)
project(shl C CXX)

file (STRINGS "version" SHL_VERSION)
set(SHL_MAJOR_VERSION 2)

enable_language(ASM)

if(EXISTS ${CMAKE_CURRENT_BINARY_DIR}/config.cmake)
  include(${CMAKE_CURRENT_BINARY_DIR}/config.cmake)
else()
  if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/config.cmake)
    include(${CMAKE_CURRENT_SOURCE_DIR}/config.cmake)
  endif()
endif()

file(GLOB_RECURSE _GLOB_SHL_NN2_SRCS source/nn2/*.c source/utils/*.c source/utils/*.cpp)
file(GLOB_RECURSE _GLOB_SHL_REF_SRCS source/reference/*.c)
file(GLOB_RECURSE _GLOB_SHL_GREF_SRCS source/graph_ref/*.c)
file(GLOB_RECURSE _GLOB_SHL_THEAD_RVV_SRCS source/thead_rvv/*.c)
list(APPEND _GLOB_SHL_SRCS ${_GLOB_SHL_NN2_SRCS}
                           ${_GLOB_SHL_REF_SRCS}
                           ${_GLOB_SHL_GREF_SRCS}
                           ${_GLOB_SHL_THEAD_RVV_SRCS})

add_library(shl STATIC ${_GLOB_SHL_SRCS})

set(SHL_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/include
                     ${CMAKE_CURRENT_SOURCE_DIR}/include/csinn
                     ${CMAKE_CURRENT_SOURCE_DIR}/include/graph
                     ${CMAKE_CURRENT_SOURCE_DIR}/include/backend)

target_include_directories(shl PRIVATE ${SHL_INCLUDE_DIRS})
target_include_directories(shl PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src)

set(RVV_BUILD_FLAGS -ffp-contract=off -march=rv64gcv0p7_zfh_xtheadc -mabi=lp64d -DSHL_BUILD_RVV -DSHL_BUILD_REF -DSHL_BUILD_GREF)
target_compile_options(shl PRIVATE ${RVV_BUILD_FLAGS})

set_target_properties(shl PROPERTIES FOLDER "shl")
set_property(TARGET shl PROPERTY POSITION_INDEPENDENT_CODE ON)
