/* 
 * File:   gpu.h
 * Author: aliendo
 *
 * Created on 26 de diciembre de 2013, 11:23 AM
 */


#ifndef GPU_H
#define	GPU_H

#include <iostream>
#include <string>
#include <sstream>
#include <stdlib.h>
//#include <mpi.h>
// "/usr/include/openmpi-x86_64/mpi.h"
using namespace std;

class gpu {
public:
    bool present;
    int deviceCount;//Indica el numero de GPU disponibles
    string *name;//Indica el nombre de cada GPU. Debe ser un arreglo del tamaño de deviceCount
    int *major;//Major revision number. Debe ser un arreglo del tamaño de deviceCount
    int *minor;//Minor revision number. Debe ser un arreglo del tamaño de deviceCount
    unsigned int *totalGlobalMem;//Total amount of global memory. Debe ser un arreglo del tamaño de deviceCount
    int *multiProcessorCount;//Number of multiprocessors. Debe ser un arreglo del tamaño de deviceCount
    int *numCores;//Number of cores. Debe ser un arreglo del tamaño de deviceCount
    unsigned int *totalConstMem;//Total amount of constant memory. Debe ser un arreglo del tamaño de deviceCount
    unsigned int *sharedMemPerBlock;//Total amount of shared memory per block. Debe ser un arreglo del tamaño de deviceCount
    int *regsPerBlock;//Total number of registers available per block. Debe ser un arreglo del tamaño de deviceCount
    int *warpSize;//Warp size. Debe ser un arreglo del tamaño de deviceCount
    int *maxThreadsPerBlock;//Maximum number of threads per block. Debe ser un arreglo del tamaño de deviceCount
    int *maxThreadsDim0, *maxThreadsDim1, *maxThreadsDim2;//Maximum sizes of each dimension of a block. Debe ser un arreglo del tamaño de deviceCount
    int *maxGridSize0, *maxGridSize1, *maxGridSize2;//Maximum sizes of each dimension of a grid. Debe ser un arreglo del tamaño de deviceCount
    unsigned int *memPitch;//Maximum memory pitch. Debe ser un arreglo del tamaño de deviceCount
    unsigned int *textureAlignment;//Texture alignment. Debe ser un arreglo del tamaño de deviceCount
    float *clockRate;//Clock rate. Debe ser un arreglo del tamaño de deviceCount
    bool *deviceOverlap;//Concurrent copy and execution. Debe ser un arreglo del tamaño de deviceCount

    gpu();
    gpu(bool verify);

    /*Para empaquetado de datos*/
    gpu(void *buf,int size);
    void pack(void *buf, int size);

    /*gpu(const gpu& orig);
    virtual ~gpu();*/
    bool getPresent();
    void setDeviceCount();
    void setDeviceProperties();
    void setPresent();
    void gpuCopy(gpu aCopiar);
    void complete();
   
    /*Para descubrimiento de la clase*/
    int natr;
    string *valueatr;
    string *nameatr;
    int getNatr();//Indica el numero de atributos
    string getValueatr(int n);//Indica el tipo de dato del atributo
    string getNameatr(int n);//Indica el nombre del atributo

private:
    void setNatr();
    void setValueatr();
    void setNameatr();

};

#endif	/* GPU_H */

