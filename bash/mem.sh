# not working for 1 2 and above

#!/bin/bash

declare -A cache

amem(){
	local m=$1
	local n=$2

	if [[ -n ${cache[$1$2]} ]]
	then
		echo ${cache["$m,$n"]}
		return
	fi

	if [[ $m -eq 0 ]]
	then
		#echo one
		result=$(($n+1))
	elif [[ $n -eq 0 ]]
	then
		result=$(amem $(($m-1)) 1)
	else
		result=$(amem $(($m-1)) $(amem $m $(($n-1))) )
	fi

	cache["$m,$n"]=$result

	echo $result
}

amem $1 $2
