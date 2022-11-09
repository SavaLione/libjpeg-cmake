cmake_minimum_required (VERSION 3.17)

message(STATUS "libjpeg version: 9e  16-Jan-2022")

project(libjpeg
    LANGUAGES C
)

# Determine if libjpeg is built as a subproject (using add_subdirectory)
# or if it is the master project.
if(NOT DEFINED LIBJPEG_MASTER_PROJECT)
	set(LIBJPEG_MASTER_PROJECT OFF)
	if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
    	set(LIBJPEG_MASTER_PROJECT ON)
    	message(STATUS "CMake version: ${CMAKE_VERSION}")
  	endif ()
endif ()

option(LIBJPEG_BUILD_SHARED  "Build libjpeg shared library" ON)
option(LIBJPEG_INSTALL "Generate the install target" ${LIBJPEG_MASTER_PROJECT})

option(LIBJPEG_MEM_NOBS "No backing-store JPEG memory manager" ON)
option(LIBJPEG_MEM_ANSI "ANSI-standard JPEG memory manager" OFF)

option(LIBJPEG_BUILD_UTIL_CJPEG "Build user interface for the JPEG compressor (cjpeg)" ON)
option(LIBJPEG_BUILD_UTIL_CJPEG_ALT "Use an alternate user interface for the JPEG compressor" OFF)
option(LIBJPEG_BUILD_UTIL_DJPEG "Build user interface for the JPEG decompressor (djpeg)" ON)
option(LIBJPEG_BUILD_UTIL_DJPEG_ALT "Build an alternate user interface for the JPEG decompressor" OFF)
option(LIBJPEG_BUILD_UTIL_JPEGTRAN "Build command-line user interface for JPEG transcoding (jpegtran)" ON)
option(LIBJPEG_BUILD_UTIL_RDJPGCOM "Build very simple stand-alone application that displays the text in COM (comment) markers in a JFIF file (rdjpgcom)" ON)
option(LIBJPEG_BUILD_UTIL_WRJPGCOM "Build very simple stand-alone application that inserts user-supplied text as a COM (comment) marker in a JFIF file (wrjpgcom)" ON)
option(LIBJPEG_BUILD_UTIL_CKCONFIG "Build program that is intended to help you determine how to configure the JPEG software for installation on a particular system" ON)

# The remaining options do not affect the JPEG library proper,
# but only the sample applications cjpeg/djpeg (see cjpeg.c, djpeg.c).
# Other applications can ignore these.
option(LIBJPEG_BMP_SUPPORT "BMP image file format" ON)
option(LIBJPEG_GIF_SUPPORT "GIF image file format" ON)
option(LIBJPEG_PPM_SUPPORT "PBMPLUS PPM/PGM image file format" ON)
option(LIBJPEG_RLE_SUPPORT "Utah RLE image file format" OFF)
option(LIBJPEG_TARGA_SUPPORT "Targa image file format" ON)

option(LIBJPEG_TWO_FILE_COMMANDLINE "Define this if you want to name both input and output files on the command line, rather than using stdout and optionally stdin" OFF)
option(LIBJPEG_NEED_SIGNAL_CATCHER "Define this if your system needs explicit cleanup of temporary files" OFF)
option(LIBJPEG_DONT_USE_B_MODE "If you have one of the rare systems that complains about the \"b\" spec, define this" OFF)
option(LIBJPEG_PROGRESS_REPORT "Define this if you want percent-done progress reports from cjpeg/djpeg" OFF)

include(cmake/checks.cmake)

# Set default build to release
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose Release or Debug build type" FORCE)
endif()

message(STATUS "Build type: " ${CMAKE_BUILD_TYPE})

set(CMAKE_EXPORT_COMPILE_COMMANDS 1)

# libjpeg sources
set(LIBJPEG_SRC
	src/jaricom.c
	src/jcapimin.c
	src/jcapistd.c
	src/jcarith.c
	src/jccoefct.c
	src/jccolor.c
	src/jcdctmgr.c
	src/jchuff.c
	src/jcinit.c
	src/jcmainct.c
	src/jcmarker.c
	src/jcmaster.c
	src/jcomapi.c
	src/jcparam.c
	src/jcprepct.c
	src/jcsample.c
	src/jctrans.c
	src/jdapimin.c
	src/jdapistd.c
	src/jdarith.c
	src/jdatadst.c
	src/jdatasrc.c
	src/jdcoefct.c
	src/jdcolor.c
	src/jddctmgr.c
	src/jdhuff.c
	src/jdinput.c
	src/jdmainct.c
	src/jdmarker.c
	src/jdmaster.c
	src/jdmerge.c
	src/jdpostct.c
	src/jdsample.c
	src/jdtrans.c
	src/jerror.c
	src/jfdctflt.c
	src/jfdctfst.c
	src/jfdctint.c
	src/jidctflt.c
	src/jidctfst.c
	src/jidctint.c
#	src/jmemdos.c
#	src/jmemmac.c
	src/jmemmgr.c
#	src/jmemname.c
	src/jquant1.c
	src/jquant2.c
	src/jutils.c
)

if(LIBJPEG_MEM_ANSI)
    set(LIBJPEG_SRC ${LIBJPEG_SRC}
        src/jmemansi.c
    )
elseif(LIBJPEG_MEM_NOBS)
    set(LIBJPEG_SRC ${LIBJPEG_SRC}
        src/jmemnobs.c
    )
endif()

# libjpeg library
if(LIBJPEG_BUILD_SHARED)
    add_library(${PROJECT_NAME} SHARED ${LIBJPEG_SRC})
    target_compile_definitions(${PROJECT_NAME} PUBLIC LIBJPEG_SHARED_LIB)
else()
    add_library(${PROJECT_NAME} STATIC ${LIBJPEG_SRC})
endif()

add_library(libjpeg::libjpeg ALIAS ${PROJECT_NAME})

target_include_directories(${PROJECT_NAME} PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>" "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>")

# utils
if(LIBJPEG_BUILD_UTIL_CJPEG OR LIBJPEG_BUILD_UTIL_DJPEG OR LIBJPEG_BUILD_UTIL_JPEGTRAN OR LIBJPEG_BUILD_UTIL_RDJPGCOM OR LIBJPEG_BUILD_UTIL_WRJPGCOM OR LIBJPEG_BUILD_UTIL_CKCONFIG)
    add_subdirectory(utils)
endif()

if(LIBJPEG_INSTALL)
	install(
		TARGETS libjpeg
		EXPORT "libjpegTargets"
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
		INCLUDES DESTINATION "include"
	)

	install(FILES "include/jconfig.h" DESTINATION "include")
	install(FILES "include/jdct.h" DESTINATION "include")
	install(FILES "include/jinclude.h" DESTINATION "include")
	install(FILES "include/jmorecfg.h" DESTINATION "include")
	install(FILES "include/jpeglib.h" DESTINATION "include")
	install(FILES "include/jerror.h" DESTINATION "include")
	install(FILES "include/jmemsys.h" DESTINATION "include")
	install(FILES "include/jpegint.h" DESTINATION "include")
	install(FILES "include/jversion.h" DESTINATION "include")

	install(
    	EXPORT "libjpegTargets"
    	DESTINATION "lib/cmake/libjpeg"
	)
endif()