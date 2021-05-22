#!/bin/bash

while true; do
	for x in {1..7}; do
		fortune | cowsay | queercat -h 0.3 -v 0.3 -f $x
		sleep 1
	done
done
