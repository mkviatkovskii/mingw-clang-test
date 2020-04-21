#!/bin/bash
set -Eeuxo pipefail

# gcc libstdc++ ld
# Works fine
false && \
export BOOST_ROOT=/opt/boost-1.72.0-win-amd64-gcc-9.3.0 && \
rm -f *.o *.a ./main.gcc.libstdcxx.ld.exe && \
g++ -fopenmp -std=c++17 -o add.o -c add.cpp -I${BOOST_ROOT}/include && \
gcc-ar qc libmath.a add.o && \
g++ -fopenmp -std=c++17 -o main.o -c main.cpp && \
gcc-ar qc objects.a main.o && \
g++ -fopenmp -std=c++17 -Wl,--demangle -o main.gcc.libstdcxx.ld.exe objects.a libmath.a && \
time ./main.gcc.libstdcxx.ld.exe 1 2
unset BOOST_ROOT


# gcc libstdc++ lld
# Works with Clang 10
false  && \
export BOOST_ROOT=/opt/boost-1.72.0-win-amd64-gcc-9.3.0 && \
rm -f *.o *.a ./main.gcc.libstdcxx.lld.exe && \
g++ -fopenmp -std=c++17 -o add.o -c add.cpp -I${BOOST_ROOT}/include && \
gcc-ar qc libmath.a add.o && \
g++ -fopenmp -std=c++17 -o main.o -c main.cpp && \
gcc-ar qc objects.a main.o && \
g++ -fopenmp -std=c++17 -fuse-ld=lld -o main.gcc.libstdcxx.lld.exe objects.a libmath.a && \
time ./main.gcc.libstdcxx.lld.exe 1 2
unset BOOST_ROOT

# clang libstdc++ ld
# Works fine
true && \
export BOOST_ROOT=/opt/boost-1.72.0-win-amd64-clang10-libstdcxx && \
rm -f *.o *.a ./main.clang.libstdcxx.ld.exe && \
clang++ -fopenmp -std=c++17 -o add.o -c add.cpp -I${BOOST_ROOT}/include && \
llvm-ar qc libmath.a add.o && \
clang++ -fopenmp -std=c++17 -o main.o -c main.cpp && \
llvm-ar qc objects.a main.o && \
clang++ -fopenmp -std=c++17 -Wl,--demangle -o main.clang.libstdcxx.ld.exe objects.a libmath.a && \
time ./main.clang.libstdcxx.ld.exe 1 2
unset BOOST_ROOT

# clang libstdc++ lld
# LLD does not support linking directly with DLL, need and importlib dll.a?
true && \
export BOOST_ROOT=/opt/boost-1.72.0-win-amd64-clang10-libstdcxx && \
rm -f *.o *.a ./main.clang.libstdcxx.lld.exe && \
clang++ -fopenmp -std=c++17 -o add.o -c add.cpp -I${BOOST_ROOT}/include && \
llvm-ar qc libmath.a add.o && \
clang++ -fopenmp -std=c++17 -o main.o -c main.cpp && \
llvm-ar qc objects.a main.o && \
clang++ -fopenmp -std=c++17 -fuse-ld=lld -o main.clang.libstdcxx.lld.exe objects.a libmath.a && \
time ./main.clang.libstdcxx.lld.exe 1 2
unset BOOST_ROOT

# clang libc++ ld
# LLVM OpenMP in not supported in MinGW, usin GNU OpenMP
true && \
export BOOST_ROOT=/opt/boost
rm -f *.o *.a ./main.clang.libcxx.ld.exe && \
clang++ -fopenmp -std=c++17 -stdlib=libc++ -o add.o -c add.cpp -I${BOOST_ROOT}/include && \
llvm-ar qc libmath.a add.o && \
clang++ -fopenmp -std=c++17 -stdlib=libc++ -o main.o -c main.cpp && \
llvm-ar qc objects.a main.o && \
clang++ -fopenmp -std=c++17 -stdlib=libc++ -Wl,--demangle -o main.clang.libcxx.ld.exe objects.a libmath.a && \
time ./main.clang.libcxx.ld.exe 1 2
unset BOOST_ROOT

# clang libc++ lld
# FIXME: duplicate sumbols issue
false && \
export BOOST_ROOT=/opt/boost && \
rm -f *.o *.a ./main.clang.libcxx.lld.exe && \
clang++ -fopenmp -std=c++17 -stdlib=libc++ -o add.o -c add.cpp -I${BOOST_ROOT}/include && \
llvm-ar qc libmath.a add.o && \
clang++ -fopenmp -std=c++17 -stdlib=libc++ -o main.o -c main.cpp && \
llvm-ar qc objects.a main.o && \
clang++ -fopenmp -std=c++17 -stdlib=libc++ -fuse-ld=lld -o main.clang.libcxx.lld.exe libmath.a objects.a && \
time ./main.clang.libcxx.lld.exe 1 2
unset BOOST_ROOT
