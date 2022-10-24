#!/usr/bin/bash

curl http://www7.uc.cl/sw_educ/conectores/html/concepto.html > file4.txt
grep -i $1 file4.txt > /dev/null
if [ $? -ne 0 ]; then
	echo No se ha encontrado la palabra $1
else
	RECUENTO=$(grep -ic $1 file4.txt)
	LINEA=$(grep -in -m 1 $1 file4.txt | cut -f1 -d:) 
	echo La palabra \"$1\" aparece $RECUENTO veces
	echo Aparece por primera vez en la linea $LINEA
fi
