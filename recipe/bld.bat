COPY %RECIPE_DIR%\CMakeLists.txt %SRC_DIR%\CMakeLists.txt
mkdir build
cd build

cmake -G "NMake Makefiles" ^
      -DBUILD_SHARED_LIBS="1" ^
      -DCMAKE_BUILD_TYPE="Release" ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      ..

if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1
