if(LIBJPEG_BUILD_UTIL_CJPEG)
    add_subdirectory(cjpeg)
endif()

if(LIBJPEG_BUILD_UTIL_DJPEG)
    add_subdirectory(djpeg)
endif()

if(LIBJPEG_BUILD_UTIL_JPEGTRAN)
    add_subdirectory(jpegtran)
endif()

if(LIBJPEG_BUILD_UTIL_RDJPGCOM)
    add_subdirectory(rdjpgcom)
endif()

if(LIBJPEG_BUILD_UTIL_WRJPGCOM)
    add_subdirectory(wrjpgcom)
endif()

if(LIBJPEG_BUILD_UTIL_CKCONFIG)
    add_subdirectory(ckconfig)
endif()