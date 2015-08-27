#!/bin/bash

function benchmark(){
	BENCHMARKEE="$1"
	RAW_RESULTS="$(/usr/bin/time -f "%E,%M,%R" $BENCHMARKEE 2>&1 >/dev/null)"
	echo "$RAW_RESULTS"
}

echo "Elapsed (Wall Clock) Time, Maximum Resident Set Size (kbytes), Minor (reclaiming a frame) page faults"
for i in $(seq 1 20);
do
	echo $(benchmark "$1")
done


#echo "$FILTERED_RESULTS"


