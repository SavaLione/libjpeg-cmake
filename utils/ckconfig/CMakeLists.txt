cmake_minimum_required (VERSION 3.17)

project(ckconfig
    LANGUAGES C
)

add_executable(${PROJECT_NAME} src/ckconfig.c)

target_link_libraries(${PROJECT_NAME} libjpeg::libjpeg)

if(LIBJPEG_INSTALL)
	install(
		TARGETS ckconfig
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
	)
endif()