/* 
 * File:   gpu.cpp
 * Author: aliendo
 * 
 * Created on 26 de diciembre de 2013, 11:23 AM
 */

#include "gpu.h"
/*
gpu::gpu() {
    setPresent();
    int deviceCount;

    if (present){
        cudaGetDeviceCount(&deviceCount);
        if (deviceCount == 0) {
            cout << "There is no device supporting CUDA" << endl;
            gpu(false);
        } else {
            cout << "Nro de dispostivos:" << deviceCount << ":" << endl;
            setDeviceProperties();
        }
    } else {
            deviceCount = 0;
            name = new string[1];
            name[0]=" ";
            major = new int[1];
            major[0]=0;
            minor = new int[1];
            minor[0]=0;
            totalGlobalMem = new unsigned int[1];
            totalGlobalMem[0]=0;
            multiProcessorCount = new int[1];
            multiProcessorCount[0]=0;
            numCores = new int[1];
            numCores[0]=0;
            totalConstMem = new unsigned int[1];
            totalConstMem[0]=0;
            sharedMemPerBlock = new unsigned int[1];
            sharedMemPerBlock[0]=0;
            regsPerBlock = new int[1];
            regsPerBlock[0]=0;
            warpSize = new int[1];
            warpSize[0]=0;
            maxThreadsPerBlock = new int[1];
            maxThreadsPerBlock[0]=0;
            maxThreadsDim0 = new int[1];
            maxThreadsDim0[0]=0;
            maxThreadsDim1 = new int[1];
            maxThreadsDim1[0]=0;
            maxThreadsDim2 = new int[1];
            maxThreadsDim2[0]=0;
            maxGridSize0 = new int[1];
            maxGridSize0[0]=0;
            maxGridSize1 = new int[1];
            maxGridSize1[0]=0;
            maxGridSize2 = new int[1];
            maxGridSize2[0]=0;
            memPitch = new unsigned int[1];
            memPitch[0]=0;
            textureAlignment = new unsigned int[1];
            textureAlignment[0]=0;
            clockRate = new float[1];
            clockRate[0]=0;
            deviceOverlap = new bool[1];
            deviceOverlap[0]=0;
    }

    setNatr();
    setValueatr();
    setNameatr();
}
*/

void gpu::setDeviceProperties(){
    int dev;
    cudaDeviceProp deviceProp;

    name = new string[deviceCount];
    major = new int[deviceCount];
    minor = new int[deviceCount];
    totalGlobalMem = new unsigned int[deviceCount];
    multiProcessorCount = new int[deviceCount];
    numCores = new int[deviceCount];
    totalConstMem = new unsigned int[deviceCount];
    sharedMemPerBlock = new unsigned int[deviceCount];
    regsPerBlock = new int[deviceCount];
    warpSize = new int[deviceCount];
    maxThreadsPerBlock = new int[deviceCount];
    maxThreadsDim0 = new int[deviceCount];
    maxThreadsDim1 = new int[deviceCount];
    maxThreadsDim2 = new int[deviceCount];
    maxGridSize0 = new int[deviceCount];
    maxGridSize1 = new int[deviceCount];
    maxGridSize2 = new int[deviceCount];
    memPitch = new unsigned int[deviceCount];
    textureAlignment = new unsigned int[deviceCount];
    clockRate = new float[deviceCount];
    deviceOverlap = new bool[deviceCount];

    for (dev = 0; dev < deviceCount; ++dev) {
        cudaGetDeviceProperties(&deviceProp, dev);
        if (dev == 0) {
            if (deviceProp.major == 9999 && deviceProp.minor == 9999){
                //cout << "There is no device supporting CUDA." << endl;
		gpu(false);
	    }
        }
	name[dev]=deviceProp.name;
	major[dev]=deviceProp.major;
	minor[dev]=deviceProp.minor;
	totalGlobalMem[dev]=(unsigned int)deviceProp.totalGlobalMem;
    #if CUDART_VERSION >= 2000
	multiProcessorCount[dev]=deviceProp.multiProcessorCount;
	numCores[dev]=8 * deviceProp.multiProcessorCount;
    #else
	multiProcessorCount[dev]=0;
	numCores[dev]=0;
    #endif
	totalConstMem[dev]=(unsigned int)deviceProp.totalConstMem;
	sharedMemPerBlock[dev]=(unsigned int)deviceProp.sharedMemPerBlock;
	regsPerBlock[dev]=deviceProp.regsPerBlock;
	warpSize[dev]=deviceProp.warpSize;
	maxThreadsPerBlock[dev]=deviceProp.maxThreadsPerBlock;
	maxThreadsDim0[dev]=deviceProp.maxThreadsDim[0];
	maxThreadsDim1[dev]=deviceProp.maxThreadsDim[1];
	maxThreadsDim2[dev]=deviceProp.maxThreadsDim[2];
	maxGridSize0[dev]=deviceProp.maxGridSize[0];
	maxGridSize1[dev]=deviceProp.maxGridSize[1];
	maxGridSize2[dev]=deviceProp.maxGridSize[2];
	memPitch[dev]=(unsigned int)deviceProp.memPitch;
	textureAlignment[dev]=(unsigned int)deviceProp.textureAlignment;
	clockRate[dev]=deviceProp.clockRate * 1e-6f;
    #if CUDART_VERSION >= 2000
	deviceOverlap[dev]=deviceProp.deviceOverlap;
    #else
	deviceOverlap[dev]=false;
    #endif
    }
}

void gpu::setDeviceCount(){
    if (present){
        cudaGetDeviceCount(&deviceCount);
    } else { 
	deviceCount=0;
    }
}
