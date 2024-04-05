#!/bin/bash

skip=0
DAEMON=$1

DATA=$(systemd-cgtop -n1 | grep $DAEMON | awk '{print $4}' | head -n1)

case "$DATA" in
  '')
    echo -1
    exit
    ;;
  *K)
    power=1
    ;;
  *M)
    power=2
    ;;
  *G)
    power=3
    ;;
  *T)
    power=4
    ;;
  *P)
    power=5
    ;;
  *)
    power=0
    skip=1
    ;;
esac

echo $DATA
if [ $skip -ne 1 ]; then
  DATA=$(echo $DATA | sed 's/.$//')
fi
echo $(echo $DATA | sed 's/.$//')
echo $DATA
echo "$DATA * 1024^$power" | bc
