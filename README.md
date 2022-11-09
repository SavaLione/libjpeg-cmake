# libjpeg-cmake
This is an unofficial CMake implementation of the [libjpeg](https://www.ijg.org) library.

libjpeg version: 9e of 16-Jan-2022

Independent JPEG Group: https://www.ijg.org/

## Compile and install
```sh
$ git clone https://github.com/SavaLione/libjpeg-cmake
$ cd libjpeg-cmake
$ mkdir build
$ cd build
$ cmake ..
$ make
```

### Build options
* ``LIBJPEG_BUILD_SHARED`` (default: ``ON``): Build shared library
* ``LIBJPEG_INSTALL`` Generate the install target
* ``LIBJPEG_MEM_NOBS`` (default: ``ON``): No backing-store JPEG memory manager
* ``LIBJPEG_MEM_ANSI`` (default: ``OFF``): ANSI-standard JPEG memory manager
* ``LIBJPEG_BUILD_UTIL_CJPEG`` (default: ``ON``): Build user interface for the JPEG compressor (cjpeg)
* ``LIBJPEG_BUILD_UTIL_CJPEG_ALT`` (default: ``OFF``): Use an alternate user interface for the JPEG compressor
* ``LIBJPEG_BUILD_UTIL_DJPEG`` (default: ``ON``): Build user interface for the JPEG decompressor (djpeg)
* ``LIBJPEG_BUILD_UTIL_DJPEG_ALT`` (default: ``OFF``): Build an alternate user interface for the JPEG decompressor
* ``LIBJPEG_BUILD_UTIL_JPEGTRAN`` (default: ``ON``): Build command-line user interface for JPEG transcoding (jpegtran)
* ``LIBJPEG_BUILD_UTIL_RDJPGCOM`` (default: ``ON``): Build very simple stand-alone application that displays the text in COM (comment) markers in a JFIF file (rdjpgcom)
* ``LIBJPEG_BUILD_UTIL_WRJPGCOM`` (default: ``ON``): Build very simple stand-alone application that inserts user-supplied text as a COM (comment) marker in a JFIF file (wrjpgcom)
* ``LIBJPEG_BUILD_UTIL_CKCONFIG`` (default: ``ON``): Build program that is intended to help you determine how to configure the JPEG software for installation on a particular system

The remaining options do not affect the JPEG library proper, but only the sample applications cjpeg/djpeg (see cjpeg.c, djpeg.c).
Other applications can ignore these.
* ``LIBJPEG_BMP_SUPPORT`` (default: ``ON``): BMP image file format
* ``LIBJPEG_GIF_SUPPORT`` (default: ``ON``): GIF image file format
* ``LIBJPEG_PPM_SUPPORT`` (default: ``ON``): PBMPLUS PPM/PGM image file format
* ``LIBJPEG_RLE_SUPPORT`` (default: ``OFF``): Utah RLE image file format
* ``LIBJPEG_TARGA_SUPPORT`` (default: ``ON``): Targa image file format
* ``LIBJPEG_TWO_FILE_COMMANDLINE`` (default: ``OFF``): Define this if you want to name both input and output files on the command line, rather than using stdout and optionally stdin
* ``LIBJPEG_NEED_SIGNAL_CATCHER`` (default: ``OFF``): Define this if your system needs explicit cleanup of temporary files
* ``LIBJPEG_DONT_USE_B_MODE`` (default: ``OFF``): If you have one of the rare systems that complains about the "b" spec, define this
* ``LIBJPEG_PROGRESS_REPORT`` (default: ``OFF``): Define this if you want percent-done progress reports from cjpeg/djpeg

## Additional information
* Author of this unofficial CMake implementation: Saveliy Pototskiy ([savalione.com](https://savalione.com))
* Link to Github: https://github.com/SavaLione/libjpeg-cmake
* Date of creation: 2022-11-09