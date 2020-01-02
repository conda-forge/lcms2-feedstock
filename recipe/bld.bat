COPY %RECIPE_DIR%\build.sh build.sh

set MSYSTEM=MINGW%ARCH%
set MSYS2_PATH_TYPE=inherit
set CHERE_INVOKING=1

REM Taken from https://github.com/conda-forge/opencv-feedstock/blob/master/recipe/bld.bat#L23
set UNIX_PREFIX=%PREFIX:\=/%
set UNIX_LIBRARY_PREFIX=%LIBRARY_PREFIX:\=/%
set UNIX_LIBRARY_BIN=%LIBRARY_BIN:\=/%
set UNIX_LIBRARY_INC=%LIBRARY_INC:\=/%
set UNIX_LIBRARY_LIB=%LIBRARY_LIB:\=/%

bash -lc "ln -s ${LOCALAPPDATA}/Temp /tmp"
bash -exlc "./build.sh"
if errorlevel 1 exit 1

exit 0
