/* 
 * File:   gpu.cpp
 * Author: aliendo
 * 
 * Created on 26 de diciembre de 2013, 11:23 AM
 */

#include "gpu.h"

gpu::gpu() {
    setPresent();
    if (present){
        setNx();
        setNy();
    } else {
        nx=0;
        ny=0;
    }
    
    setNatr();
    setValueatr();
    setNameatr();    
}

gpu::gpu(bool verify) {
    if (!verify){
        present=false;
        nx=0;
        ny=0;
    }    
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

void gpu::setNx(){
    nx=2048;
}

void gpu::setNy(){
    ny=1024;
}

bool gpu::getPresent(){
    return present;
}

int gpu::getNx(){
    return nx;
}

int gpu::getNy(){
    return ny;
}

void gpu::gpuCopy(gpu* aCopiar){
    nx=aCopiar->nx;
    ny=aCopiar->ny;
    present=aCopiar->present;         
    complete();    
}

//Para descubrir la clase
void gpu::setNatr(){
	natr=3;
}

void gpu::setValueatr(){
    valueatr = new string[natr];
    
    stringstream auxss;

    auxss << present << ",";  
    valueatr[0]=auxss.str();
    auxss.str(string());
      
    auxss << nx << ",";  
    valueatr[1]=auxss.str();
    auxss.str(string());
      
    auxss << ny ;  
    valueatr[2]=auxss.str();
    auxss.str(string());
}

void gpu::setNameatr(){
    nameatr = new string[natr];
    
    nameatr[0]="present";
    nameatr[1]="nx";
    nameatr[2]="ny";
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

