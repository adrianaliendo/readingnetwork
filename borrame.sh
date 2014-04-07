#!/bin/bash
ISNVCC=`which nvcc`
echo $ISNVCC
if [ "$ISNVCC" = "" ]; then
        echo "No tiene cuda"
else
        echo "Tiene cuda"
fi

ISNVCC=` which nvcc` 
