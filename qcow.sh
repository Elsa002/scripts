#!/bin/bash

while true; do
	for x in {1..7}; do
		fortune | cowsay | queercat -h 1 -v 0.5 -b -f $x
		sleep 1
	done
done
