set UseEnv=true

REM copy %LIBRARY_LIB%\tiff.lib %LIBRARY_LIB%\libtiff.lib

msbuild ^
  /p:Platform=x64 ^
  /p:Configuration=Release ^
  /p:AdditionalIncludeDirectories=%LIBRARY_INC% ^
  /p:AdditionalDependencies=/LIBPATH:%LIBRARY_LIB% ^
  Projects\VC2017\lcms2.sln
if errorlevel 1 exit 1

dir
dir bin
dir include
dir lib

COPY bin\jpegicc.exe  %LIBRARY_BIN%\jpgicc.exe
COPY bin\tifficc.exe  %LIBRARY_BIN%\tificc.exe
COPY bin\linkicc.exe  %LIBRARY_BIN%\linkicc.exe
COPY bin\transicc.exe %LIBRARY_BIN%\transicc.exe
COPY bin\psicc.exe    %LIBRARY_BIN%\psicc.exe

COPY bin\lcms2.dll    %LIBRARY_BIN%\lcms2.dll

COPY bin\lcms2.lib    %LIBRARY_LIB%\lcms2.lib

COPY include\lcms2.h  %LIBRARY_LIB%\lcms2.h
COPY include\lcms2_plugin.h  %LIBRARY_LIB%\lcms2_plugin.h


REM COPY %RECIPE_DIR%\CMakeLists.txt %SRC_DIR%\CMakeLists.txt
REM mkdir build
REM cd build

REM cmake -G "NMake Makefiles" ^
REM       -DBUILD_SHARED_LIBS="1" ^
REM       -DCMAKE_BUILD_TYPE="Release" ^
REM       -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
REM       ..

REM if errorlevel 1 exit 1

REM nmake
REM if errorlevel 1 exit 1

REM nmake install
REM if errorlevel 1 exit 1
