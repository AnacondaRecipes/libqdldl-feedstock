:: Initially configure with QDLDL_BUILD_STATIC_LIB ON to run tests
cmake -G Ninja -B build -S %SRC_DIR% ^
    -DCMAKE_BUILD_TYPE=Debug ^
    -DQDLDL_BUILD_SHARED_LIB=OFF ^
    -DQDLDL_BUILD_STATIC_LIB=ON ^
    -DQDLDL_UNITTESTS=ON
if errorlevel 1 exit 1

:: Build.
cmake --build build
if errorlevel 1 exit 1

:: Test
cmake --build build --target test
if errorlevel 1 exit 1

:: Cleanup
cmake --build build --target clean
if errorlevel 1 exit 1

:: Re-configure with QDLDL_BUILD_STATIC_LIB OFF to install only shared library
cmake -G Ninja -B build -S %SRC_DIR% ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DQDLDL_BUILD_SHARED_LIB=ON ^
    -DQDLDL_BUILD_STATIC_LIB=OFF ^
    -DQDLDL_UNITTESTS=OFF
if errorlevel 1 exit 1

:: Install.
cmake --build build --config Release --target install
if errorlevel 1 exit 1