#!/bin/bash

function benchmark(){
	BENCHMARKEE="$1"
	PRIMECOUNT="$2"
	RAW_RESULTS="$(/usr/bin/time -f "%E,%M" $BENCHMARKEE "$PRIMECOUNT" 2>&1 >/dev/null)"
	echo "$RAW_RESULTS"
}

echo "Nth Prime, Elapsed (Wall Clock) Time, Maximum Resident Set Size (kbytes)"
for k in $(seq 0 20);
do
	PRIMECOUNT="$(echo "100000+(45000*$k)" | bc)"

	echo "$PRIMECOUNT,$(benchmark $1 $PRIMECOUNT)"
	#for i in $(seq 1 5);
	#do
	#	echo $(benchmark "$1")
	#done
done

#echo "$FILTERED_RESULTS"


