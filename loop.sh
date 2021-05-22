#!/bin/bash

if [ $# -lt 2 ]; then
	echo not enough arguments!
	exit 2
fi

while true; do
	$2
	sleep $1 
done
