cmake_minimum_required (VERSION 3.17)

project(wrjpgcom
    LANGUAGES C
)

add_executable(${PROJECT_NAME} src/wrjpgcom.c)

target_link_libraries(${PROJECT_NAME} libjpeg::libjpeg)

if(LIBJPEG_INSTALL)
	install(
		TARGETS wrjpgcom
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
	)
endif()