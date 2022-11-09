include(CheckIncludeFile)
include(CheckSymbolExists)
include(CheckCSourceCompiles)

message(CHECK_START "Checking C compiler and linker")
list(APPEND CMAKE_MESSAGE_INDENT "  ")
unset(missingComponents)

set(CMAKE_REQUIRED_QUIET ON)

# Although a real ANSI C compiler can deal perfectly well with pointers to
# unspecified structures (see "incomplete types" in the spec), a few pre-ANSI
# and pseudo-ANSI compilers get confused.  To keep one of these bozos happy,
# define INCOMPLETE_TYPES_BROKEN.  This is not recommended unless you
# actually get "missing structure definition" warnings or errors while
# compiling the JPEG code.
message(CHECK_START "Are incomplete types working?")
check_c_source_compiles(
"
char a[];
int main(){}
"
INCOMPLETE_TYPES_BROKEN)
if(INCOMPLETE_TYPES_BROKEN)
    message(CHECK_PASS "Yes")
else()
    message(CHECK_PASS "No")
endif()

# Define this if your linker needs global names to be unique in less
# than the first 15 characters.
message(CHECK_START "Does compiler support short non-unique (first 15 characters) external names?")
check_c_source_compiles(
"
extern int abcdefghijkjlmnopqrstuvwxyz123456;
extern int abcdefghijkjlmnopqrstuvwxyz123457;
int main(){}
"
NEED_SHORT_EXTERNAL_NAMES)
if(NEED_SHORT_EXTERNAL_NAMES)
    message(CHECK_PASS "Yes")
else()
    message(CHECK_PASS "No")
endif()

message(CHECK_START "Does compiler support function prototypes?")
check_c_source_compiles(
"
int f();
int f() {}

int main(){}
"
HAVE_PROTOTYPES)
if(HAVE_PROTOTYPES)
    message(CHECK_PASS "Yes")
else()
    message(CHECK_PASS "No")
endif()


message(CHECK_START "Does compiler support \"const\" keyword?")
check_c_source_compiles(
"
int main()
{
    const int i = 0;
}
"
HAVE_CONST)
if(HAVE_CONST)
    message(CHECK_PASS "Yes")
else()
    message(CHECK_PASS "No")
endif()

if(HAVE_CONST)
    set(NEED_CONST OFF)
else()
    set(NEED_CONST ON)
endif()

message(CHECK_START "Does compiler support \"const\" type?")
check_c_source_compiles(
"
void f() {}
int main(){}
"
HAVE_VOID)
if(HAVE_VOID)
    message(CHECK_PASS "Yes")
else()
    message(CHECK_PASS "No")
endif()

if(HAVE_VOID)
    set(NEED_VOID OFF)
else()
    set(NEED_VOID ON)
endif()

message(CHECK_START "Does compiler support the declaration \"unsigned char\" ?")
check_c_source_compiles(
"
unsigned char uc;
int main(){}
"
HAVE_UNSIGNED_CHAR)
if(HAVE_UNSIGNED_CHAR)
    message(CHECK_PASS "Yes")
else()
    message(CHECK_PASS "No")
endif()

message(CHECK_START "Does compiler support the declaration \"unsigned short\" ?")
check_c_source_compiles(
"
unsigned short us;
int main(){}
"
HAVE_UNSIGNED_SHORT)
if(HAVE_UNSIGNED_SHORT)
    message(CHECK_PASS "Yes")
else()
    message(CHECK_PASS "No")
endif()

message(CHECK_START "Is \"short\" type unsigned?")
check_c_source_compiles(
"
int main()
{
    /* x[-1] if signed */
    short x[ (short)0xffff ];
}
"
SHORT_IS_UNSIGNED)
if(SHORT_IS_UNSIGNED)
    message(CHECK_PASS "Yes")
else()
    message(CHECK_PASS "No")
endif()

message(CHECK_START "Is \"char\" type unsigned?")
check_c_source_compiles(
"
int main()
{
    /* x[-1] if signed */
    char x[ (char)0xff ];
}
"
CHAR_IS_UNSIGNED)
if(CHAR_IS_UNSIGNED)
    message(CHECK_PASS "Yes")
else()
    message(CHECK_PASS "No")
endif()

message(CHECK_START "Is right shift \">>\" signed?")
check_c_source_compiles(
"
int main()
{
    /* x[-1] if unsigned */
    char x[ ((signed char)0xff) >> 1 ];
}
"
RIGHT_SHIFT_IS_UNSIGNED)
if(RIGHT_SHIFT_IS_UNSIGNED)
    message(CHECK_PASS "Yes")
else()
    message(CHECK_PASS "No")
endif()

list(POP_BACK CMAKE_MESSAGE_INDENT)

check_include_file(stddef.h HAVE_STDDEF_H)
check_include_file(stdlib.h HAVE_STDLIB_H)
check_include_file(string.h HAVE_STRING_H)
check_symbol_exists(size_t stddef.h stdlib.h stdio.h HAVE_ANSI_SIZE_T)
check_symbol_exists(setmode io.h USE_SETMODE)

if(HAVE_STRING_H)
    set(NEED_BSD_STRINGS OFF)
else()
    set(NEED_BSD_STRINGS ON)
endif()

if(HAVE_ANSI_SIZE_T)
    set(NEED_SYS_TYPES_H OFF)
else()
    set(NEED_SYS_TYPES_H ON)
endif()

# To minimize application namespace pollution, the symbols won't be defined unless JPEG_INTERNALS has been defined
if(RIGHT_SHIFT_IS_UNSIGNED)
    set(JPEG_INTERNALS OFF)
else()
    set(JPEG_INTERNALS ON)
endif()


if(LIBJPEG_BMP_SUPPORT)
    set(BMP_SUPPORTED ON)
endif()

if(LIBJPEG_GIF_SUPPORT)
    set(GIF_SUPPORTED ON)
endif()

if(LIBJPEG_PPM_SUPPORT)
    set(PPM_SUPPORTED ON)
endif()

if(LIBJPEG_RLE_SUPPORT)
    set(RLE_SUPPORTED ON)
endif()

if(LIBJPEG_TARGA_SUPPORT)
    set(TARGA_SUPPORTED ON)
endif()

if(LIBJPEG_TWO_FILE_COMMANDLINE)
    set(TWO_FILE_COMMANDLINE ON)
endif()

if(LIBJPEG_NEED_SIGNAL_CATCHER)
    set(NEED_SIGNAL_CATCHER ON)
endif()

if(LIBJPEG_DONT_USE_B_MODE)
    set(DONT_USE_B_MODE ON)
endif()

if(LIBJPEG_PROGRESS_REPORT)
    set(PROGRESS_REPORT ON)
endif()

if(LIBJPEG_BUILD_UTIL_CJPEG OR LIBJPEG_BUILD_UTIL_DJPEG OR LIBJPEG_BUILD_UTIL_JPEGTRAN OR LIBJPEG_BUILD_UTIL_RDJPGCOM OR LIBJPEG_BUILD_UTIL_WRJPGCOM)
    set(JPEG_CJPEG_DJPEG ON)
endif()

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/include/jconfig.h.in ${CMAKE_CURRENT_SOURCE_DIR}/include/jconfig.h)