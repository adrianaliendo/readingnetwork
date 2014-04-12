#!/bin/bash
export PROGS=main
export CC=mpic++ 
export NVCC=nvcc 
export OMPFLAG=-fopenmp
#export CUDAFLAG="-lgomp -lmpi --compiler-bindir mpic++"
export CUDAFLAG="-Xcompiler -fopenmp -lcuda -lcudart -lgomp -lmpi --compiler-bindir mpic++"
export CUDAMPIFLAG="/usr/local/cuda-5.0/lib64/ -lcudart"
#export CUDAFLAG="-Xcompiler -lcuda -lcudart -lgomp -lmpi"
ISNVCC=`which nvcc`

echo "Compilando Todo junto"

if [ "$ISNVCC" = "" ]; then
ln -s -f gpu.cu gpu.cpp
$CC -DCUDA=0 $OMPFLAG gpu.cpp node.cpp jsonfile.cpp main.cpp -o readingnetwork
else
$NVCC -DCUDA=1  $CUDAFLAG gpu.cu node.cpp jsonfile.cpp main.cpp -o readingnetwork
fi
