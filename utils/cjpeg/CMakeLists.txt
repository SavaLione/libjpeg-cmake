cmake_minimum_required (VERSION 3.17)

project(cjpeg
    LANGUAGES C
)

set(CJPEG_SRC
    src/cdjpeg.c
    src/rdbmp.c
    src/rdgif.c
    src/rdppm.c
    src/rdrle.c
    src/rdswitch.c
    src/rdtarga.c
)

if(LIBJPEG_BUILD_UTIL_CJPEG_ALT)
    set(CJPEG_SRC ${CJPEG_SRC} src/cjpegalt.c)
else()
    set(CJPEG_SRC ${CJPEG_SRC} src/cjpeg.c)
endif()

add_executable(${PROJECT_NAME} ${CJPEG_SRC})
target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/include)

target_link_libraries(${PROJECT_NAME} libjpeg::libjpeg)

if(LIBJPEG_INSTALL)
	install(
		TARGETS cjpeg
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
	)
endif()