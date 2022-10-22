#!/bin/bash

# Shebang

# Описание:
# Проверка связи для мониторинга доступности хоста
#
# Использование:
# pingmonitor.sh <file> <seconds>
#
# <file> Файл, содержащий список хостов
#
# <seconds> Количество секунд между пингами
#
while true
do
    clear
    echo 'Cybersecurity Ops System Monitor'
    echo 'Status: Scanning ...'
    echo '-----------------------------------------'
    while read -r ipadd
    do
        ipadd=$(echo "$ipadd" | sed 's/\r//')  # удаление строк после чтения поля из файла
        ping -c 1 "$ipadd" | egrep '(Destination host unreachable|100%)' &> /dev/null  # ping -n "for windows"
                             # Проверка связи с хостом                                 # ping -c "for Linuxs"
        if (( "$?" == 0 ))   # код 0, обнаружены строки с ошибками, хост не ответил на ping
        then
            tput setaf 1     # Установка красного цвета шрифта для важного текста
            echo "Host $ipadd not found - $(date)" | tee -a monitorlog.txt # Добавление сообщения в файл 
                             # и уведомление о том что хост не найден
            tput setaf 7
        fi
    done < "$1"

    echo ""
    echo "Done."

    for ((i="$2"; i > 0; i--))  # Запуск обратного отчета времени до начала следующего сканирования.
    do
        tput cup 1 0            # Перемещение курсора в строку 1, столбец 0
        echo "Status: Next scan in $i seconds"
        sleep 1
    done
done
