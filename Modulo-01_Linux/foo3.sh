#!/usr/bin/bash

if [ $# -gt 1 ]; then
	echo "Demasiados argumentos!"
	exit 1
fi

mkdir -p foo/dummy
mkdir foo/empty

if [ $# -lt 1 ]; then
	echo "Que me gusta la bash!!!!" > foo/dummy/file1.txt
else
	echo $1 > foo/dummy/file1.txt
fi

touch foo/dummy/file2.txt
cat foo/dummy/file1.txt > foo/dummy/file2.txt
mv foo/dummy/file2.txt foo/empty/
