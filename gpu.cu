/* 
 * File:   gpu.cpp
 * Author: aliendo
 * 
 * Created on 26 de diciembre de 2013, 11:23 AM
 */

#include "gpu.h"
#include <mpi.h>

gpu::gpu() {

    setDeviceCount();
    if (present){
        if (deviceCount == 0) {
	    gpu(false);
	} else {
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

gpu::gpu(bool verify) {
    if (!verify){
        present=false;
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
    } else {
	gpu();
    }   
}

gpu::gpu(void *buf, int size){
    int offset=0,aux,nelem=1;
    int auxsize;
    MPI::INT.Unpack(buf,size,&aux,1,offset,MPI::COMM_WORLD);
    if(aux==1) present=true;
    else present=false;
    MPI::INT.Unpack(buf,size,&deviceCount,1,offset,MPI::COMM_WORLD);
    if(deviceCount!=0) nelem=deviceCount;
    name = new string[nelem];
    major = new int[nelem];
    minor = new int[nelem];
    totalGlobalMem = new unsigned int[nelem];
    multiProcessorCount = new int[nelem];
    numCores = new int[nelem];
    totalConstMem = new unsigned int[nelem];
    sharedMemPerBlock = new unsigned int[nelem];
    regsPerBlock = new int[nelem];
    warpSize = new int[nelem];
    maxThreadsPerBlock = new int[nelem];
    maxThreadsDim0 = new int[nelem];
    maxThreadsDim1 = new int[nelem];
    maxThreadsDim2 = new int[nelem];
    maxGridSize0 = new int[nelem];
    maxGridSize1 = new int[nelem];
    maxGridSize2 = new int[nelem];
    memPitch = new unsigned int[nelem];
    textureAlignment = new unsigned int[nelem];
    clockRate = new float[nelem];
    deviceOverlap = new bool[nelem];

    MPI::INT.Unpack(buf,size,&auxsize,1,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,name,auxsize,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,major,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,minor,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,totalGlobalMem,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,multiProcessorCount,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,numCores,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,totalConstMem,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,sharedMemPerBlock,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,regsPerBlock,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,warpSize,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,maxThreadsPerBlock,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,maxThreadsDim0,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,maxThreadsDim1,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,maxThreadsDim2,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,maxGridSize0,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,maxGridSize1,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,maxGridSize2,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,memPitch,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,textureAlignment,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,clockRate,nelem,offset,MPI::COMM_WORLD);
    MPI::INT.Unpack(buf,size,deviceOverlap,nelem,offset,MPI::COMM_WORLD);
}

void gpu::pack(void *buf, int size){
    int offset=0,aux,nelem=1;
    int auxsize=name[0].length();
    if(present) aux=1;
    else aux=0;
    MPI::INT.Pack(&aux,1,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(&deviceCount,1,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(&auxsize,1,buf,size,offset,MPI::COMM_WORLD);
    if(deviceCount!=0) nelem=deviceCount;
    MPI::INT.Pack(name,auxsize*nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(major,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(minor,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(totalGlobalMem,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(multiProcessorCount,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(numCores,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(totalConstMem,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(sharedMemPerBlock,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(regsPerBlock,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(warpSize,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(maxThreadsPerBlock,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(maxThreadsDim0,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(maxThreadsDim1,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(maxThreadsDim2,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(maxGridSize0,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(maxGridSize1,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(maxGridSize2,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(memPitch,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(textureAlignment,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(clockRate,nelem,buf,size,offset,MPI::COMM_WORLD);
    MPI::INT.Pack(deviceOverlap,nelem,buf,size,offset,MPI::COMM_WORLD);
}

void gpu::complete(){
    setNatr();
    setValueatr();
    setNameatr();      
}

void gpu::setPresent(){
    int auxsystem;
    auxsystem=system("which nvcc > nul 2>&1");
    if (auxsystem==0)
        present=true;
    else
        present=false;
}

bool gpu::getPresent(){
    return present;
}

void gpu::setDeviceProperties(){
#if CUDA
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
#endif
}

void gpu::gpuCopy(gpu aCopiar){
    int dev;
    present=aCopiar.present;
    if(present){
        deviceCount=aCopiar.deviceCount;
        for (dev = 0; dev < deviceCount; ++dev) {
            name[dev]=aCopiar.name[dev];
            major[dev]=aCopiar.major[dev];
            minor[dev]=aCopiar.minor[dev];
            totalGlobalMem[dev]=aCopiar.totalGlobalMem[dev];
            multiProcessorCount[dev]=aCopiar.multiProcessorCount[dev];
            numCores[dev]=aCopiar.multiProcessorCount[dev];
            totalConstMem[dev]=aCopiar.totalConstMem[dev];
            sharedMemPerBlock[dev]=aCopiar.sharedMemPerBlock[dev];
            regsPerBlock[dev]=aCopiar.regsPerBlock[dev];
            warpSize[dev]=aCopiar.warpSize[dev];
            maxThreadsPerBlock[dev]=aCopiar.maxThreadsPerBlock[dev];
            maxThreadsDim0[dev]=aCopiar.maxThreadsDim0[dev];
            maxThreadsDim1[dev]=aCopiar.maxThreadsDim1[dev];
            maxThreadsDim2[dev]=aCopiar.maxThreadsDim2[dev];
            maxGridSize0[dev]=aCopiar.maxGridSize0[dev];
            maxGridSize1[dev]=aCopiar.maxGridSize1[dev];
            maxGridSize2[dev]=aCopiar.maxGridSize2[dev];
            memPitch[dev]=aCopiar.memPitch[dev];
            textureAlignment[dev]=aCopiar.textureAlignment[dev];
            clockRate[dev]=aCopiar.clockRate[dev];
            deviceOverlap[dev]=aCopiar.deviceOverlap[dev];
        }
    }
    complete();    
}

//Para descubrir la clase
void gpu::setNatr(){
    if (present){
	natr=23;
    } else {
        natr=1;
    }
}

void gpu::setValueatr(){
    valueatr = new string[natr];
    
    
    stringstream auxss;

    if(present){
        auxss << present << ",";  
        valueatr[0]=auxss.str();
        auxss.str(string());

        auxss << deviceCount << ",";  
        valueatr[1]=auxss.str();
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << name[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[2]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << major[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[3]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << minor[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[4]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << totalGlobalMem[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[5]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << multiProcessorCount[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[6]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << numCores[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[7]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << totalConstMem[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[8]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << sharedMemPerBlock[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[9]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << regsPerBlock[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[10]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << warpSize[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[11]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << maxThreadsPerBlock[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[12]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << maxThreadsDim0[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[13]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << maxThreadsDim1[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[14]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << maxThreadsDim2[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[15]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << maxGridSize0[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[16]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << maxGridSize1[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[17]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << maxGridSize2[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[18]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << memPitch[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[19]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << textureAlignment[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[20]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << clockRate[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[21]=auxss.str().append("],");
        auxss.str(string());

        auxss << "[";
        for (int i=0; i<deviceCount;i++){
            auxss << deviceOverlap[i];
            if(i!=deviceCount-1)
                auxss << ",";  
        } 
        valueatr[22]=auxss.str().append("]");
        auxss.str(string());
    } else {
        auxss << present ;  
        valueatr[0]=auxss.str();
        auxss.str(string());
    
    }
}

void gpu::setNameatr(){
    nameatr = new string[natr];

    nameatr[0]="present";
    if(present){
        nameatr[1]="deviceCount";
        nameatr[2]="name";
        nameatr[3]="major";
        nameatr[4]="minor";
        nameatr[5]="totalGlobalMem";
        nameatr[6]="multiProcessorCount";
        nameatr[7]="numCores";
        nameatr[8]="totalConstMem";
        nameatr[9]="sharedMemPerBlock";
        nameatr[10]="regsPerBlock";
        nameatr[11]="warpSize";
        nameatr[12]="maxThreadsPerBlock";
        nameatr[13]="maxThreadsDim0";
        nameatr[14]="maxThreadsDim1";
        nameatr[15]="maxThreadsDim2";
        nameatr[16]="maxGridSize0";
        nameatr[17]="maxGridSize1";
        nameatr[18]="maxGridSize2";
        nameatr[19]="memPitch";
        nameatr[20]="textureAlignment";
        nameatr[21]="clockRate";
        nameatr[22]="deviceOverlap";
    }
}

int gpu::getNatr(){
	return natr;
}

string gpu::getValueatr(int n){
	if (n<getNatr())
		return valueatr[n];
	else
		exit(EXIT_FAILURE);	

	
}
	
string gpu::getNameatr(int n){
	if (n<getNatr())
		return nameatr[n];
	else
		exit(EXIT_FAILURE);	
}

/*gpu::gpu(const gpu& orig) {
}

gpu::~gpu() {
}*/

void gpu::setDeviceCount(){
#if CUDA
   cudaGetDeviceCount(&deviceCount);
   if(deviceCount==0) present=false;
   else present=true;
#else
   deviceCount=0;
   present=false;
#endif
}

