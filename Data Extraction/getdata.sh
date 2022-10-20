#!/bin/bash
#Shebang

# Скрипт предназначен для извлечения данных из графы title и вывода в stdout в алфавитном порядке

function get_list () {

for as in $(egrep -i 'title' $lib | head -n 2 | awk 'BEGIN{FS=":"} {print $2}'| cut -d'"' -f2)
do 
echo $as
done | sort
}

lib=(./lib.json)
get_list