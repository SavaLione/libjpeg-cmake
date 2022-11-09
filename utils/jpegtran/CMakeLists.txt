cmake_minimum_required (VERSION 3.17)

project(jpegtran
    LANGUAGES C
)

set(JPEGTRAN_SRC
    src/cdjpeg.c
    src/jpegtran.c
    src/rdswitch.c
    src/transupp.c
)

add_executable(${PROJECT_NAME} ${JPEGTRAN_SRC})
target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/include)

target_link_libraries(${PROJECT_NAME} libjpeg::libjpeg)

if(LIBJPEG_INSTALL)
	install(
		TARGETS jpegtran
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
	)
endif()