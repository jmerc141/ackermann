#!/bin/bash

ackr(){
	if [ $1 -eq 0 ]
	then
		echo -n $(($2+1))
	elif [ $2 -eq 0 ]
	then
		ackr $(($1-1)) 1
	else
		ackr $(($1-1)) $(ackr $1 $(($2-1)))
	fi

}

ackr $1 $2