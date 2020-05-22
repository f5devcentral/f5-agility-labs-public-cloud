#!/bin/bash
for f in $(ls ./images | sort -n); do
	echo \
		".. image:: ./images/$f
	   :scale: 50%" >> lab1.rst;
   done
