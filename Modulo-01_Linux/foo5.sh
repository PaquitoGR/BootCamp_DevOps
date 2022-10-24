#!/usr/bin/bash

if [ $# -ne 2 ]; then
	echo Se necesitan únicamente 2 parámeteros para ejecutar este script
	exit 1
else
	curl $1 > file5.txt
	grep -i $2 file5.txt > /dev/null
	if [ $? -ne 0 ]; then
        	echo No se ha encontrado la palabra $2
	else
        RECUENTO=$(grep -ic $2 file5.txt)
		LINEA=$(grep -in -m 1 $2 file5.txt | cut -f1 -d:)
	        if [ $RECUENTO = 1 ]; then
			echo La palabra \"$2\" aparece 1 vez
			echo Aparece únicamente en la línea $LINEA
		else
			echo La palabra \"$2\" aparece $RECUENTO veces
	        	echo Aparece por primera vez en la linea $LINEA
		fi
	fi
fi	
