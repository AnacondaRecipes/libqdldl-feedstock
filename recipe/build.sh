#!/bin/sh

# Initially compile with QDLDL_BUILD_STATIC_LIB ON to run tests
cmake ${CMAKE_ARGS} -G Ninja -B build -S . \
      -DCMAKE_BUILD_TYPE=Debug \
      -DQDLDL_BUILD_SHARED_LIB=OFF \
      -DQDLDL_BUILD_STATIC_LIB=ON \
      -DQDLDL_UNITTESTS=ON

# Run tests
cmake --build build
cmake --build build --target test
cmake --build build --target clean

# Re-configure with QDLDL_BUILD_STATIC_LIB OFF to install only shared library
cmake -G Ninja -B build -S . \
      -DCMAKE_BUILD_TYPE=Release \
      -DQDLDL_BUILD_SHARED_LIB=ON \
      -DQDLDL_BUILD_STATIC_LIB=OFF \
      -DQDLDL_UNITTESTS=OFF 

cmake --build build --config Release --parallel ${CPU_COUNT} --target install
