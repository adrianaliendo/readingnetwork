#include <cstdlib>
#include <iostream>
#include <stdlib.h>
#include <mpi.h>
#include "omp.h"
#include "node.h"
#include "jsonfile.h"
#include "gpu.h"

//using namespace std;

int main(int argc, char *argv[]){
	/*
 * 	Para compilar: mpic++ -fopenmp <clases>.cpp ReadingNetwork.cpp -o ReadingNetwork
 * 		Para ejecutar:mpirun ./ReadingNetwork -np <nro de procesadores> 
 * 			*/

    int numprocs, idnode;
    MPI::Init(argc,argv);
    MPI::COMM_WORLD.Set_errhandler(MPI::ERRORS_THROW_EXCEPTIONS);
    
    try{
        node cluster;
//printf("Termina?\n");
        //Se escribe la informacion en formato json
        int id;
        //Todos los nodos revisan que hilos le corresponde
        #pragma omp parallel private(id)
        {
        
            id=omp_get_thread_num();    
            if(cluster.idnode==0 && id==0){
               jsonfile jsonnodes;
               jsonnodes.setPathfile("json/prueba.json");
               jsonnodes.jsonwrite("{",true);
               string aux;
               for(int i=0;i<cluster.getNatr();i++){
                   aux="\"";
                   jsonnodes.jsonwrite(aux.append(cluster.getNameatr(i).append("\":")).append(cluster.getValueatr(i)),false);
               }

               jsonnodes.jsonwrite("}",false);
            }
        
        }
      
    } catch(MPI::Exception e) {
        cout << "MPI ERROR: " << e.Get_error_code() << " - " << e.Get_error_string() << std::endl;
    }


     try {
//printf("Finalize\n");
         MPI::Finalize();
     } catch (MPI::Exception e) {
         cout << "MPI ERROR(F): " << e.Get_error_code() << " - " << e.Get_error_string() << std::endl;
     }

             
    return 0;

}

