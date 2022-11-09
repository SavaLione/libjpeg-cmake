cmake_minimum_required (VERSION 3.17)

project(djpeg
    LANGUAGES C
)

set(DJPEG_SRC
    src/cdjpeg.c
    src/rdcolmap.c
    src/wrbmp.c
    src/wrgif.c
    src/wrppm.c
    src/wrrle.c
    src/wrtarga.c
)

if(LIBJPEG_BUILD_UTIL_DJPEG_ALT)
    set(DJPEG_SRC ${DJPEG_SRC}
        src/djpegalt.c
    )
else()
    set(DJPEG_SRC ${DJPEG_SRC}
        src/djpeg.c
    )
endif()

add_executable(${PROJECT_NAME} ${DJPEG_SRC})
target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/include)

target_link_libraries(${PROJECT_NAME} libjpeg::libjpeg)

if(LIBJPEG_INSTALL)
	install(
		TARGETS djpeg
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
	)
endif()