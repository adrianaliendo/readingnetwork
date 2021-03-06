/* 
 * File:   node.cpp
 * Author: aliendo
 * 
 * Created on 11 de diciembre de 2013, 09:59 AM
 */

#include "node.h"
#include <stdio.h>
#define TAG 0

node::node() {
        setNumnode();//Inicializa numtask, cuenta el numero de tareas en total
        unic = new bool[numtask];
        
        idnodes = new int[numtask];
        auxidnodes = new int[numtask];
        threads = new int[numtask];
        names = new string[numtask];
        
        //Al crear los objetos gpu, de una vez se revisa si existe o no, y se asignan
        //los valores correspondientes
        gpusinfo = new gpu[numtask];

        //Inicializa idnode, por nodo y luego reparte la informacion con el nodo principal en idnodes
        setIdnode();//asigna un id a cada nodo
        
        //Inicializa namenode, por nodo
        //Necesito saber el nombre de los nodos, verifico que no se repite 
        //y cuento el numero efectivo de procesadores
        setNamenode();

        //Inicializa nthread, por nodo y luego reparte la informacion con el nodo principal en threads
        //setThread();
        setNThreads();

        MPI::Status stat;
    	//int tam=( 21*8*sizeof(int) )*10 ; //Define el tamanio del objeto gpu (Estoy agregando el 10, porque en algunos equipos tam se queda corto)
	int tam=10000;
    	char *buffer = new char[tam];  
        int aux;

        if(numtask>1){
            //Si tiene mas de un nodo debe proceder de una forma
            if(idnode==0){
                //El nodo principal debe recibir la informacion para almacenarla en gpusinfo
                for(int j=1;j<numtask;j++){
		    if(auxidnodes[j]!=-1){
		        MPI::COMM_WORLD.Recv((void *)buffer, tam, MPI::PACKED, j, TAG, stat);
		        gpu gpuaux((void *)buffer, tam);//Este constructor se encarga de desempaquetar la información 
 			    			      		  //almacenada en buffer y lo guarda en el objeto gpuaux
                        //Despues que desempaca todo, debe almacenar el objeto recibido en
                        //uno de los elementos del gpusinfo 
                        // //gpuaux.complete();
                        gpusinfo[j].gpuCopy(gpuaux);
		    }
                }            
            } else if(auxidnodes[idnode]!=-1) {//Solo los nodos que son unicos, envían datos al nodo principal
                //debe enviar la informacion que tienen a la mano
	        gpuinfo.pack((void *)buffer,tam);
                MPI::COMM_WORLD.Send((void *)buffer, tam, MPI::PACKED, 0, TAG);
            }
            MPI::COMM_WORLD.Barrier();
        } else {
            //Si solo tine un nodo,... independientemente de si tiene presente o no
	    gpusinfo[0].gpuCopy(gpuinfo);
        }
        if(idnode==0){
	    setNatr();
	    setValueatr();
	    setNameatr();
	}
}

void node::setNumnode(){
	numtask = MPI::COMM_WORLD.Get_size();
}

void node::setIdnode(){
    idnode = MPI::COMM_WORLD.Get_rank();
    //cout << "idnode_setIdnode:" << idnode << endl;
    if(numtask>1){
        MPI::COMM_WORLD.Gather(&idnode,1,MPI_INT,idnodes,1,MPI_INT,0);
    } else {
        idnodes[0]=idnode;
    }
}

void node::setNamenode(){
    MPI::Status stat;
    string namesaux[numtask];
    char aux[MPI_MAX_PROCESSOR_NAME];
    MPI::Get_processor_name(namenode,large_name);
    for (int i=0;i<numtask;i++){
        unic[i]=true;
    }
    if (numtask>1){
        if(idnode==0){
            //Si es el principal, incializa names[0] de una vez, y recibe el resto de los otros nodos
            namesaux[0]=namenode;
            for(int i=1;i<numtask;i++){
                MPI::COMM_WORLD.Recv(aux, MPI_MAX_PROCESSOR_NAME, MPI_CHAR, i, TAG, stat);
                namesaux[i]=aux;
            }
            //Despues que tengo toda la informacion en el arreglo que me interesa, debo poder diferenciarla
            //para saber que no es el mismo procesador
            for(int i=0;i<numtask;i++){
                if (unic[i]!=false){
                    //Si es diferente de falso, es porque no lo he marcado todavia
                    // y comparo con todos los que tiene despues para marcarlos a ellos
                    for(int j=i+1;j<numtask;j++){
                        if(namesaux[i]==namesaux[j]){
                            //Si los nombres son iguales, es el mismo procesador 
                            unic[j]=false;
                        }
                    }
                }
            }
            numprocs=0;
            for(int i=0;i<numtask;i++){
                if(unic[i]){ 
                    //Si es verdadero, entonces es un nuevo procesador
                    names[numprocs]=namesaux[i];
                    //Y en auxidnode guardo el numero del procesador al que pertenece
                    auxidnodes[i]=i;
                    numprocs++;
                } else {
                    //Para saber que esta vacio
                    auxidnodes[i]=-1;
                }
            }
        } else {
            //Sino, debe enviar su informacion en namenode al nodo principal
            MPI::COMM_WORLD.Send(namenode, MPI_MAX_PROCESSOR_NAME, MPI_CHAR, 0, TAG);
        }

    } else {
        names[0]=namenode;
        numprocs=1;
        auxidnodes[0]=0;
    }
    MPI::COMM_WORLD.Bcast(auxidnodes,numtask,MPI::INT,0);
    //names queda con un tamanio de mas!!!
}

void node::setNThreads(){
	#pragma omp parallel
	{ nthread=omp_get_num_threads();     	} //Todos los nodos revisan cuantos hilos hay por nodo
	if (numtask>1){
            MPI::COMM_WORLD.Gather(&nthread,1,MPI_INT,threads,1,MPI_INT,0); //Y envian al nodo principal su informacion
        } else {
            threads[0]=nthread;
        }
        //cout << "nthread_setNThreads:" << nthread << endl;
}

void node::setThread(){
       //Esta funcion no esta operativa, pues no hace lo que deberia hacer todavia
       /* int id;
	#pragma omp parallel private(id) //Todos los nodos revisan que hilos le corresponde
	{ id=omp_get_thread_num();     	
          printf("0-nthread_setThread:%d\n",id);
          threadids[id]=id;
         } */
	/*if (numtask>1){
            MPI::COMM_WORLD.Gather(&threadid,1,MPI_INT,threadids,1,MPI_INT,0); //Y envian al nodo principal su informacion
        } else {
            threadids[0]=threadid;
        }*/
}


//Para descubrir la clase
void node::setNatr(){
	natr=5;
}

void node::setValueatr(){
    int flag=0;
    valueatr = new string[natr];
    
    stringstream auxss;

    auxss << numtask << ",";  
    valueatr[0]=auxss.str();
    auxss.str(string());

    auxss << numprocs << ",";  
    valueatr[1]=auxss.str();
    auxss.str(string());

    auxss << "[";
    for (int i=0; i<numtask;i++){
        if(auxidnodes[i]>=0){
		flag++;
		auxss << auxidnodes[i];
		if(flag!=numprocs)
		    auxss << ",";  
	}
    } 
    valueatr[2]=auxss.str().append("],");
    auxss.str(string());

    flag=0;
    auxss << "[";
    for (int i=0; i<numtask;i++){
        if(auxidnodes[i]!=-1){
		flag++;
	        auxss << threads[auxidnodes[i]];
        	if(flag!=numprocs)
        	    auxss << ",";  
	}
    } 
    valueatr[3]=auxss.str().append("],");
    auxss.str(string());

    flag=0;
    auxss << "[";
    for (int i=0; i<numtask;i++){
        if(auxidnodes[i]!=-1){
		flag++;
		auxss << "{\n";
		for (int j=0; j<gpusinfo[auxidnodes[i]].getNatr();j++){    
		    auxss << "\"";
		    auxss << gpusinfo[auxidnodes[i]].getNameatr(j) << "\":" << gpusinfo[auxidnodes[i]].getValueatr(j); 
		    auxss << "\n";            
		}         
		auxss << "}";
		if(flag!=numprocs)
		    auxss << ",";  
        }
    }
    valueatr[4]=auxss.str().append("]");    

}

void node::setNameatr(){
    nameatr = new string[natr];
    
    nameatr[0]="numtask";
    nameatr[1]="numprocs";
    nameatr[2]="idnodes";
    nameatr[3]="threads";
    nameatr[4]="gpuinfo";
}

int node::getNatr(){
	return natr;
}

string node::getValueatr(int n){
	if (n<getNatr())
		return valueatr[n];
	else
		exit(EXIT_FAILURE);	

	
}
	
string node::getNameatr(int n){
	if (n<getNatr())
		return nameatr[n];
	else
		exit(EXIT_FAILURE);	
}

/*node::~node() {
 * }*/

