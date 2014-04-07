/* 
 * File:   gpu.cpp
 * Author: aliendo
 * 
 * Created on 26 de diciembre de 2013, 11:23 AM
 */

#include "gpu.h"

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
    }    
}
/*
gpu::gpu(void *buf, int size){
	int offset=0,aux;
	MPI::INT.Unpack(buf,size,&aux,1,offset,MPI::COMM_WORLD);
	if(aux==1) present=true;
	else present=false;
	MPI::INT.Unpack(buf,size,&deviceCount,1,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,name,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,major,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,minor,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,totalGlobalMem,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,multiProcessorCount,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,numCores,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,totalConstMem,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,sharedMemPerBlock,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,regsPerBlock,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,warpSize,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,maxThreadsPerBlock,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,maxThreadsDim0,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,maxThreadsDim1,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,maxThreadsDim2,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,maxGridSize0,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,maxGridSize1,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,maxGridSize2,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,memPitch,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,textureAlignment,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,clockRate,deviceCount,offset,MPI::COMM_WORLD);
	MPI::INT.Unpack(buf,size,deviceOverlap,deviceCount,offset,MPI::COMM_WORLD);
}

void gpu::pack(void *buf, int size){
	int offset=0,aux;
	if(present) aux=1;
	else aux=0;
	MPI::INT.Pack(&aux,1,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(&deviceCount,1,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(name,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(major,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(minor,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(totalGlobalMem,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(multiProcessorCount,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(numCores,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(totalConstMem,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(sharedMemPerBlock,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(regsPerBlock,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(warpSize,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(maxThreadsPerBlock,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(maxThreadsDim0,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(maxThreadsDim1,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(maxThreadsDim2,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(maxGridSize0,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(maxGridSize1,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(maxGridSize2,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(memPitch,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(textureAlignment,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(clockRate,deviceCount,buf,size,offset,MPI::COMM_WORLD);
	MPI::INT.Pack(deviceOverlap,deviceCount,buf,size,offset,MPI::COMM_WORLD);
}
*/
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

void gpu::gpuCopy(gpu* aCopiar){
    int dev;
    present=aCopiar->present;
    deviceCount=aCopiar->deviceCount;
    for (dev = 0; dev < deviceCount; ++dev) {
	name[dev]=aCopiar->name[dev];
	major[dev]=aCopiar->major[dev];
	minor[dev]=aCopiar->minor[dev];
	totalGlobalMem[dev]=aCopiar->totalGlobalMem[dev];
	multiProcessorCount[dev]=aCopiar->multiProcessorCount[dev];
	numCores[dev]=aCopiar->multiProcessorCount[dev];
	totalConstMem[dev]=aCopiar->totalConstMem[dev];
	sharedMemPerBlock[dev]=aCopiar->sharedMemPerBlock[dev];
	regsPerBlock[dev]=aCopiar->regsPerBlock[dev];
	warpSize[dev]=aCopiar->warpSize[dev];
	maxThreadsPerBlock[dev]=aCopiar->maxThreadsPerBlock[dev];
	maxThreadsDim0[dev]=aCopiar->maxThreadsDim0[dev];
	maxThreadsDim1[dev]=aCopiar->maxThreadsDim1[dev];
	maxThreadsDim2[dev]=aCopiar->maxThreadsDim2[dev];
	maxGridSize0[dev]=aCopiar->maxGridSize0[dev];
	maxGridSize1[dev]=aCopiar->maxGridSize1[dev];
	maxGridSize2[dev]=aCopiar->maxGridSize2[dev];
	memPitch[dev]=aCopiar->memPitch[dev];
	textureAlignment[dev]=aCopiar->textureAlignment[dev];
	clockRate[dev]=aCopiar->clockRate[dev];
	deviceOverlap[dev]=aCopiar->deviceOverlap[dev];
    }
    complete();    
}

//Para descubrir la clase
void gpu::setNatr(){
	natr=23;
}

void gpu::setValueatr(){
    valueatr = new string[natr];
    
    stringstream auxss;

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
    valueatr[22]=auxss.str().append("],");
    auxss.str(string());

}

void gpu::setNameatr(){
    nameatr = new string[natr];
//Actualizar todo
    /*nameatr[0]="present";
    nameatr[1]="nx";
    nameatr[2]="ny";*/
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

