set UseEnv=true

REM copy %LIBRARY_LIB%\tiff.lib %LIBRARY_LIB%\libtiff.lib

msbuild ^
  /p:Platform=x64 ^
  /p:Configuration=Release ^
  /p:AdditionalIncludeDirectories=%LIBRARY_INC% ^
  /p:AdditionalDependencies=/LIBPATH:%LIBRARY_LIB% ^
  Projects\VC2017\lcms2.sln
if errorlevel 1 exit 1

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
