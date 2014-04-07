PROGS=main
CC=mpic++ 
NVCC=nvcc 
CFLAG=-fopenmp

.PHONY: all clean

all: fwcapa0
	
gpu.o: gpu.cu
	$(NVCC) -c gpu.cu -o gpu.o

node.o: node.cpp
	$(CC) -c $(CFLAGS) node.cpp -o node.o

main.o: main.cpp
	$(CC) -c $(CFLAGS) main.cpp -o main.o
	
fwcapa0:  gpu.o node.o jsonfile.o
	#$(CC) $(CFLAG) main.o node.o gpu.o -o fwcapa0
	$(NVCC) -Xcompiler -fopenmp -lcuda -lcudart -lgomp -lmpi node.o gpu.o main.o -o fwcapa0
	
	
clean:
	rm -fv *.o fwcapa0
	
