/* 
 * File:   jsonfile.h
 * Author: aliendo
 *
 * Created on 20 de diciembre de 2013, 09:20 PM
 */

#ifndef JSONFILE_H
#define	JSONFILE_H

#include <iostream>
#include <string>
#include <stdlib.h>
using namespace std;


class jsonfile {
public:
    string pathfile;
    //fstream jfile;
    jsonfile();
    void setPathfile(string pathf);
    void jsonwrite(string info, bool mode);
    //virtual ~jsonfile();
private:

};

#endif	/* JSONFILE_H */

