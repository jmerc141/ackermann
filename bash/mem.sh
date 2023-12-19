# not working for 1 2 and above

#!/bin/bash

declare -A ack
#ack[$1$2]="hello"
m=$1
n=$2

amem(){
	#echo $1 $2
	if [[ -n "${ack[$1$2]}" ]]
	then
		echo here
	else
		#echo s
		if [[ $1 -eq 0 ]]
		then
			#echo one
			ack[$1$2]=$(($2+1))
		elif [[ $2 -eq 0 ]]
		then
			#echo two
			ack[$1$2]=$(amem $(($1-1)) 1)
		else
			#echo three
			tmp=$(amem $(($m-1)) $(amem $m $(($n-1))) )
			ack[$1$2]=$tmp
		fi
	fi
	echo ${ack[$1$2]}
	#return "${ack[$1 $2]}"
	
}

amem $1 $2
echo ${!ack[@]}: ${ack[@]}