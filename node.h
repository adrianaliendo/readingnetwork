/* 
 * File:   node.h
 * Author: aliendo
 *  
 * Created on 11 de diciembre de 2013, 09:59 AM
 */

#ifndef NODE_H
#define	NODE_H

#include <iostream>
#include <string>
#include <sstream>
#include <stdlib.h>
#include <mpi.h>
#include "omp.h"
#include "gpu.h"
using namespace std;


class node {
public:
    int numprocs;//Numero de procesadores usados
    int numtask;//Numero de tareas que se ejecuta, deberia ser numprocs x nthread en cada procesador
    int idnode;//Identificador del nodo (varibale auxiliar)
    int *idnodes;//Identificador de cada nodo
    int *auxidnodes;//Para identificar a que procesador corresponde ese nodo
    int nthread;//Numero de hilos en un solo procesador (variable auxiliar)
    int *threads;//Numero de hilos, por procesador. Se recopila la infomacion en esta variable (Deberia ser numprocs)
    int threadid;//Numero de hilos en un solo procesador (variable auxiliar)
    int *threadids;//Numero de hilos, por procesador. Se recopila la infomacion en esta variable (Deberia ser numprocs)
    gpu gpuinfo;//Informacion de los gpu por nodo
    gpu *gpusinfo; //Informacion de los gpu recopilada
    bool *unic;
    
    char namenode[MPI_MAX_PROCESSOR_NAME];//Nombre del procesador en un solo procesador (variable auxiliar)
    string *names;//Nombre de cada procesador. Se recopila la informacion en esta variable (Deberia ser numprocs) 
    int large_name;

    node();
    void setIdnode();
    void setNamenode();
    void setNumnode();
    void setNThreads();
    void setThread();

    /*Para la transmision de datos empaquetados*/
    //node(void *, int, MPI::Comm&);
    //pack(void *, int, MPI::Comm&);
    
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

    /*node(const node& orig);
 *     virtual ~node();*/

};

#endif	/* NODE_H */

