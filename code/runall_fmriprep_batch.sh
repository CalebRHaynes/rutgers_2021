#!/bin/bash

for sub in "1001" "1002" "1003" "1005" "1006" "1007" "1008" "1009" "1010" "1011" "1012" "1013" "1014" "1015" "1016" \
    "1017" "1018" "1019" "1020" "1021" "1022" "1023" "1024" "1025" "1026" "1027" "1028"; do

  	NCORES=5

    script=./fmriprep.sh

  	while [ $(ps -ef | grep -v grep | grep $script | wc -l) -ge $NCORES ]; do
 		sleep 1s
  	done
    $script $sub &
  	sleep 1s

done

# wait to exit so logging is correct in datalad run command
while [ $(ps -ef | grep -v grep | grep $script | wc -l) -ge 1 ]; do
    sleep 10m
    echo "STATUS: $0 is waiting to complete at `date`"
done



