#!/bin/bash

# use time ./acks.sh m n
# for timing

#source ./stack.sh

acks(){
	res=$2
	let i=0
	arr=($1)

	while [ true ]
	do
		if [[ -z "$arr" ]]
		then
			echo res: $res
			exit 0
		fi

		if [[ ${arr[$i]} -gt 0 ]] && [[ $res -gt 0 ]]
		then
			arr+=(${arr[$i]})
			((arr[$i]--))
			((res--))
			((i++))

		elif [[ ${arr[$i]} -gt 0 ]] && [[ $res -eq 0 ]]
		then
			((arr[$i]--))
			res=1

		elif [[ ${arr[$i]} -eq 0 ]]
		then
			((res++))
			unset 'arr[${#arr[@]}-1]'
			((i--))

		fi
	done
}

acks $1 $2

