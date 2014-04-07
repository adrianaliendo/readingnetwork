#!/bin/bash
export PROGS=main
export CC=mpic++ 
export NVCC=nvcc 
export OMPFLAG=-fopenmp
export CUDAFLAG="-Xcompiler -lcuda -lcudart -lgomp -lmpi"
ISNVCC=`which nvcc`

echo "Compilando GPU"
if [ "$ISNVCC" = "" ]; then
ln -s gpu.cu gpu.cpp
$CC -DCUDA=0 -c $OMPFLAGS gpu.cpp -o gpu.o
else
$NVCC -DCUDA=1 -c  -lgomp -lmpi --compiler-bindir mpic++ gpu.cu  -o gpu.o
fi

echo "Compilando NODE"
$CC -c $OMPFLAGS node.cpp -o node.o

echo "Compilando JSONFILE"
$CC -c jsonfile.cpp -o jsonfile.o

echo "Compilando MAIN"
$CC -c $OMPFLAGS main.cpp -o main.o

echo "Jutando todos los objetos con MPI"
if [ "$ISNVCC" = "" ]; then
$CC $OMPFLAG node.o gpu.o jsonfile.o main.o -o fwcapa0
else
$CC $OMPFLAG  -L /usr/local/cuda-5.0/lib64/ -lcudart   node.o gpu.o jsonfile.o main.o -o fwcapa0
fi
	
