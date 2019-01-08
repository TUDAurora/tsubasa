cmake_minimum_required(VERSION 3.12)
project(general NONE )

message( STATUS "${CMAKE_SYSTEM_NAME}" )

set( HARDWARE_NAME "-DAurora" )
set( CMAKE_CXX_DIAGNOSTIC_FLAGS "-Wall" )#-pedantic

if( CMAKE_BUILD_TYPE STREQUAL "Debug" )
    set( CMAKE_CXX_PREPROCESSOR_CONSTANTS "-DDEBUG" )
elseif( CMAKE_BUILD_TYPE STREQUAL "Release" )
    set( CMAKE_CXX_PREPROCESSOR_CONSTANTS "-DRELEASE" )
endif()

enable_language( CXX )
SET( CMAKE_SHARED_LIBRARY_LINK_C_FLAGS )
SET( CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS )

message( STATUS "${CMAKE_CXX_COMPILER}" )
if( "${CMAKE_CXX_COMPILER}" MATCHES "nc" )
    message( STATUS "NCC used" )
    set(CMAKE_COMPILER_FLAGS "-D__NCC__ -report-all -fdiag-vector=2 -fdiag-parallel=2 -fdiag-inline=2 -fdiag-system-header -assembly-list -Bstatic -static -v -lpthread" )
    set( CMAKE_COMPILER_FLAGS "${CMAKE_COMPILER_FLAGS} -std=c++14" )
    if( CMAKE_BUILD_TYPE STREQUAL "Debug" )
        if( Autovectorize )
            set( CMAKE_CXX_OPTIMIZATION_FLAGS "-O1" )
        else()
            set( CMAKE_CXX_OPTIMIZATION_FLAGS "-O0" )
        endif()
        set( CMAKE_COMPILER_FLAGS "${CMAKE_COMPILER_FLAGS} -g -ftrace -proginf -traceback" )
    elseif( CMAKE_BUILD_TYPE STREQUAL "Release" )
        if( Autovectorize )
            set( CMAKE_CXX_VECTORIZATION "-mvector" )
        else()
            set( CMAKE_CXX_VECTORIZATION "-mno-vector" )
        endif()
            #ipa is interprocedural optimization... hopefully
        set( CMAKE_CXX_OPTIMIZATION_FLAGS "${CMAKE_CXX_VECTORIZATION} -O3 -finline -finline-functions -fipa" )
    endif()


else()
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        # using Clang
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        set( CMAKE_COMPILER_FLAGS "${CMAKE_COMPILER_FLAGS} -std=c++17" )
        set( CMAKE_COMPILER_FLAGS "-D__GNUCC__ -Wextra -fopt-info-all=optimizations.log -fopt-info-optall=optimizations.log -march=native" )
        if( CMAKE_BUILD_TYPE STREQUAL "Debug" )
            set( CMAKE_CXX_OPTIMIZATION_FLAGS "-O0" )
            set( CMAKE_COMPILER_FLAGS "${CMAKE_COMPILER_FLAGS} -g" )
        elseif( CMAKE_BUILD_TYPE STREQUAL "Release" )
            set( CMAKE_CXX_OPTIMIZATION_FLAGS "-O3 -flto" )
            set( CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -mavx512f -mavx512cd -mavx512bw -mavx512vl -mavx512dq" )
        endif()
        if( Autovectorize )
            set( CMAKE_CXX_VECTORIZATION "-ftree-vectorize" )
        else()
            set( CMAKE_CXX_VECTORIZATION "-fno-tree-vectorize" )
        endif()
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")
        # using Intel C++
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
        # using V
    endif()
endif()
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_COMPILER_FLAGS}" )
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_OPTIMIZATION_FLAGS}" )
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_DIAGNOSTIC_FLAGS}" )
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_PREPROCESSOR_CONSTANTS}" )
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_VECTORIZATION}" )


MESSAGE(STATUS "Build type: " ${CMAKE_BUILD_TYPE})
MESSAGE(STATUS "Library Type: " ${LIB_TYPE})
MESSAGE(STATUS "Compiler flags:" ${CMAKE_CXX_COMPILE_FLAGS})
MESSAGE(STATUS "Compiler cxx debug flags:" ${CMAKE_CXX_FLAGS_DEBUG})
MESSAGE(STATUS "Compiler cxx release flags:" ${CMAKE_CXX_FLAGS_RELEASE})
MESSAGE(STATUS "Compiler cxx min size flags:" ${CMAKE_CXX_FLAGS_MINSIZEREL})
MESSAGE(STATUS "Compiler cxx flags:" ${CMAKE_CXX_FLAGS})

enable_testing()

add_subdirectory(src)