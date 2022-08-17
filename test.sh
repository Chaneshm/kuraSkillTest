#!/bin/bash
# questions function 
questions(){

qcount=3
i=0;	#....line counter
lineTracker=()

while [[ $i -lt $qcount ]]; do

	random=$(echo $[ 1 + $RANDOM % + 10]);

	# echo "lineTrackerLen:${#lineTracker[@]}"
	found=0
	if [ "${#lineTracker[@]}" -gt 0 ]; then
		for j in "${lineTracker[@]}"
		do
			# echo "j:${j},random:${random}"
			if [ "$j" -eq "$random" ] ; then
				# echo "Found"
				found=1
				break
		    	fi
		done
	fi

	if [ $found -eq 1 ]; then
		# We have seen this line number already...try grabbing another
		continue
	else 
		# Add this line to the lineTracker array
		lineTracker+=("${random}")
		i=$(( i+1 ))
	fi

	case $i in
	1) #random=$(echo $[ 1 + $RANDOM % + 10]);
	q1=$(echo "$(sed -n "$random{p;q}" week$userLevel.txt | cut -d'@' -f1 )");
	a1=$(echo "$(sed -n "$random{p;q}" week$userLevel.txt | cut -d'@' -f2 )");
	;;
	2) #random=$(echo $[ 1 + $RANDOM % + 10]);
	q2=$(echo "$(sed -n "$random{p;q}" week$userLevel.txt | cut -d'@' -f1 )");
	a2=$(echo "$(sed -n "$random{p;q}" week$userLevel.txt | cut -d'@' -f2 )");
	;;
	3) #random=$(echo $[ 1 + $RANDOM % + 10]);
	q3=$(echo "$(sed -n "$random{p;q}" week$userLevel.txt | cut -d'@' -f1 )");
	a3=$(echo "$(sed -n "$random{p;q}" week$userLevel.txt | cut -d'@' -f2 )");
	esac

done

}
