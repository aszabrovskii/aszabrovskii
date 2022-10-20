#!/bin/bash
export temp=0
export count=0
export resault=0
for i in $( cat $1  | grep -v "# " | awk '{print$2}' )
do
        let temp+=$i
        let count+=1
done
let resault=$temp/$count
echo $resault
exit
