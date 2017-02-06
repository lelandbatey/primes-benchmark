#!/bin/bash

function benchmark(){
	BENCHMARKEE="$1"
	PRIMECOUNT="$2"
	RAW_RESULTS="$(/usr/bin/time -f "%E,%M" $BENCHMARKEE "$PRIMECOUNT" 2>&1 >/dev/null)"
	echo "$RAW_RESULTS"
}

START=100000
STOP=1000000
INCREMENT=45000

if [ -n "$2" ]; then
	START="$2"
	if [ -z "$3" ]; then
		echo "Need to arguments for either just 'PROGRAM' or for 'PROGRAM START_PRIME STOP_PRIME INCREMENT'"
		exit 1;
	fi
fi
if [ -n "$3" ]; then
	STOP="$3"
fi


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


