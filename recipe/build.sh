#!/bin/sh

mkdir build
cd build

cmake ${CMAKE_ARGS} \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_SKIP=True \
      -DBUILD_SHARED_LIBS=ON \
      -DQDLDL_BUILD_SHARED_LIB=ON \
      -DQDLDL_BUILD_STATIC_LIB=OFF \
      -DBUILD_TESTING=ON \
      -DQDLDL_UNITTESTS=ON \
      ..

cmake --build . --config Release --parallel ${CPU_COUNT}
cmake --build . --config Release --parallel ${CPU_COUNT} --target install
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
ctest --output-on-failure -C Release
fi
