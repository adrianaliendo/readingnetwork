/* 
 * File:   jsonfile.cpp
 * Author: aliendo
 * 
 * Created on 20 de diciembre de 2013, 09:20 PM
 */

#include <fstream>

#include "jsonfile.h"

jsonfile::jsonfile() {
    pathfile="archivo.json";
}

void jsonfile::setPathfile(string pathf){
    pathfile=pathf;
}

void jsonfile::jsonwrite(string info, bool mode) {
    fstream jfile;
    if (mode)
        jfile.open(pathfile.c_str(), ios::out );
    else 
        jfile.open(pathfile.c_str(), ios::out | fstream::app);
    //jfile.open(pathfile.c_str(), ios::out | fstream::app);
    if (!jfile.is_open()){//Se verifica que el archivo se haya abierto o no
        cout << "No se pudo abrir el archivo" << endl; 
    } else {
        jfile << info << endl; //Escribe la información en el archivo
        jfile.close(); // cierra el archivo 
    }
}

/*jsonfile::~jsonfile() {
}*/

