cmake_minimum_required(VERSION 3.5)

option(CMAKE_VERBOSE_MAKEFILE "Create verbose makefile" OFF)
option(BUILD_SHARED_LIBS "Create lcms as a shared library" ON)

project(little-cms)

set(CMAKE_DEBUG_POSTFIX d)

add_library(lcms
    "${CMAKE_CURRENT_LIST_DIR}/src/cmstypes.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmsvirt.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmswtpnt.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmsxform.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/lcms2.def"
    "${CMAKE_CURRENT_LIST_DIR}/src/lcms2_internal.h"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmsalpha.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmscam02.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmscgats.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmscnvrt.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmserr.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmsgamma.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmsgmt.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmshalf.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmsintrp.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmsio0.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmsio1.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmslut.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmsmd5.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmsmtrx.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmsnamed.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmsopt.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmspack.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmspcs.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmsplugin.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmsps2.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmssamp.c"
    "${CMAKE_CURRENT_LIST_DIR}/src/cmssm.c"
)

if(BUILD_SHARED_LIBS)
    target_compile_options(lcms PRIVATE -DCMS_DLL_BUILD)
    target_compile_options(lcms PUBLIC -DCMS_DLL)
endif()

target_compile_options(lcms PRIVATE -DUNICODE -D_UNICODE)
target_include_directories(lcms PRIVATE "${CMAKE_CURRENT_LIST_DIR}/include")
set_target_properties(lcms PROPERTIES PUBLIC_HEADER "${CMAKE_CURRENT_LIST_DIR}/include/lcms2.h;${CMAKE_CURRENT_LIST_DIR}/include/lcms2_plugin.h")

add_executable(jpgicc
    "${CMAKE_CURRENT_LIST_DIR}/utils/jpgicc/iccjpeg.c"
    "${CMAKE_CURRENT_LIST_DIR}/utils/jpgicc/iccjpeg.h"
    "${CMAKE_CURRENT_LIST_DIR}/utils/jpgicc/jpgicc.c"
    "${CMAKE_CURRENT_LIST_DIR}/utils/common/vprf.c"
    "${CMAKE_CURRENT_LIST_DIR}/utils/common/xgetopt.c"
)
find_package (JPEG REQUIRED)
if (JPEG_FOUND)
  include_directories(${JPEG_INCLUDE_DIRS})
  target_link_libraries (jpegicc ${JPEG_LIBRARIES} -static)
endif (JPEG_FOUND)
target_link_libraries (jpegicc lcms -static)
target_include_directories(jpegicc PRIVATE
    "${CMAKE_CURRENT_LIST_DIR}/utils/common"
    "${CMAKE_CURRENT_LIST_DIR}/include"
)

add_executable(tifficc
    "${CMAKE_CURRENT_LIST_DIR}/utils/tificc/tificc.c"
    "${CMAKE_CURRENT_LIST_DIR}/utils/common/vprf.c"
    "${CMAKE_CURRENT_LIST_DIR}/utils/common/xgetopt.c"
)
find_package (TIFF REQUIRED)
if (TIFF_FOUND)
  include_directories(${TIFF_INCLUDE_DIRS})
  target_link_libraries (tifficc ${TIFF_LIBRARIES} -static)
endif (TIFF_FOUND)
target_link_libraries (tifficc lcms -static)
target_include_directories(tifficc PRIVATE
    "${CMAKE_CURRENT_LIST_DIR}/utils/common"
    "${CMAKE_CURRENT_LIST_DIR}/include"
)

add_executable(transicc
    "${CMAKE_CURRENT_LIST_DIR}/utils/transicc/transicc.c"
    "${CMAKE_CURRENT_LIST_DIR}/utils/common/vprf.c"
    "${CMAKE_CURRENT_LIST_DIR}/utils/common/xgetopt.c"
)
target_link_libraries (transicc lcms)
target_include_directories(transicc PRIVATE
    "${CMAKE_CURRENT_LIST_DIR}/utils/common"
    "${CMAKE_CURRENT_LIST_DIR}/include"
)

add_executable(linkicc
    "${CMAKE_CURRENT_LIST_DIR}/utils/linkicc/linkicc.c"
    "${CMAKE_CURRENT_LIST_DIR}/utils/common/vprf.c"
    "${CMAKE_CURRENT_LIST_DIR}/utils/common/xgetopt.c"
)
target_link_libraries (linkicc lcms)
target_include_directories(linkicc PRIVATE
    "${CMAKE_CURRENT_LIST_DIR}/utils/common"
    "${CMAKE_CURRENT_LIST_DIR}/include"
)

add_executable(psicc
    "${CMAKE_CURRENT_LIST_DIR}/utils/psicc/psicc.c"
    "${CMAKE_CURRENT_LIST_DIR}/utils/common/vprf.c"
    "${CMAKE_CURRENT_LIST_DIR}/utils/common/xgetopt.c"
)
target_link_libraries (psicc lcms)
target_include_directories(psicc PRIVATE
    "${CMAKE_CURRENT_LIST_DIR}/utils/common"
    "${CMAKE_CURRENT_LIST_DIR}/include"
)

install(TARGETS lcms jpegicc tifficc transicc linkicc psicc
    EXPORT lcmsConfig
    RUNTIME DESTINATION "bin"
    LIBRARY DESTINATION "lib"
    ARCHIVE DESTINATION "lib"
    PUBLIC_HEADER DESTINATION "include"
    COMPONENT dev
)

export(TARGETS lcms
    NAMESPACE lcms::
    FILE "share/lcms/lcmsConfig.cmake"
)

install(EXPORT lcmsConfig
    DESTINATION "share/lcms"
    NAMESPACE lcms::
)
