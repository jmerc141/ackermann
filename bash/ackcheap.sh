#!/bin/bash

ackr(){
	if [[ $1 -eq 0 ]]
	then
		bc <<< "$2 + 1"
	elif [[ $1 -eq 1 ]]
	then
		bc <<< "$2 + 2"
	elif [[ $1 -eq 2 ]]
	then
		bc <<< "(2*$2) + 3"
	elif [[ $1 -eq 3 ]]
	then
		bc <<< "(2^($2+3)) - 3"
	elif [[ $1 -eq 4 ]]
	then
		bc <<< "(2^2^2^2^$2) - 3"
	elif [[ $1 -eq 5 ]]
	then
		if [[ $2 -eq 0 ]]
		then
			bc <<< "(2^2^2^2^1) - 3"
		elif [[ $2 -eq 1 ]]
		then
			bc <<< "(2^2^2^2^65536) - 3"
		fi
	fi
}

ackr $1 $2