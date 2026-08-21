set UseEnv=true
set msbuildplatform=x64
if %target_platform%==win-arm64 set msbuildplatform=ARM64
msbuild ^
  /p:Platform=%msbuildplatform% ^
  /p:Configuration=Release ^
  /p:AdditionalIncludeDirectories=%LIBRARY_INC% ^
  /p:AdditionalDependencies=/LIBPATH:%LIBRARY_LIB% ^
  Projects\VC2022\lcms2.sln
if errorlevel 1 exit 1

REM For debugging Purposes, you may want to list the files in the 3 important directories
REM dir
REM dir bin
REM dir include
REM dir lib

REM Note we renamed jpegicc and tifficc to match their linux counterparts
REM That existed in conda-forge before the windows versions.

COPY bin\jpegicc.exe  %LIBRARY_BIN%\jpgicc.exe
COPY bin\tifficc.exe  %LIBRARY_BIN%\tificc.exe
COPY bin\linkicc.exe  %LIBRARY_BIN%\linkicc.exe
COPY bin\transicc.exe %LIBRARY_BIN%\transicc.exe
COPY bin\psicc.exe    %LIBRARY_BIN%\psicc.exe

COPY bin\lcms2.dll    %LIBRARY_BIN%\lcms2.dll

COPY bin\lcms2.lib    %LIBRARY_LIB%\lcms2.lib

COPY include\lcms2.h         %LIBRARY_INC%\lcms2.h
COPY include\lcms2_plugin.h  %LIBRARY_INC%\lcms2_plugin.h

REM Generate lcms2.pc from upstream template
mkdir %LIBRARY_LIB%\pkgconfig 2>nul
set LIB_PREFIX=%PREFIX:\=/%/Library
sed -e "s|@prefix@|%LIB_PREFIX%|g" ^
    -e "s|@exec_prefix@|%LIB_PREFIX%|g" ^
    -e "s|@libdir@|%LIB_PREFIX%/lib|g" ^
    -e "s|@includedir@|%LIB_PREFIX%/include|g" ^
    -e "s|@PACKAGE@|lcms2|g" ^
    -e "s|@VERSION@|%PKG_VERSION%|g" ^
    -e "s|@LIB_PLUGINS@||g" ^
    -e "s|@LIB_MATH@||g" ^
    -e "s|@LIB_THREAD@||g" ^
    %SRC_DIR%\lcms2.pc.in > %LIBRARY_LIB%\pkgconfig\lcms2.pc
if errorlevel 1 exit 1
