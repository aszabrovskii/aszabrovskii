#!/bin/bash
# Shebang
# 1
#
# https://api.pwnedpasswords.com/range/5baa6
#
# Использование: ./checkpass.sh [<password>]
# <password> Пароль для проверки
# по умолчанию: читать из stdin

if (( "$#" == 0 ))                 # Проверка был ли пароль передан в качестве аргумента. 
                                   # Если нет предлагаме ввесит пароль.
then
    printf 'Enter your password: '
    read -s passin                 # Не показываю вводимые данные, пустой оператор echo
    echo
else
    passin="$1"
fi

passin=$(echo -n "$passin" | sha1sum) # Введеный пароль преобразуется в хев SHA-1 
passin=${passin:0:40}                 # Извлекаем первые 40 символов и удаляем любые символы которые
                                      # sha1sum могла включить в свой вывод.

firstFive=${passin:0:5}               # Первые 5 символов хранятся в переменной firstFive
ending=${passin:5}                    # c 6-го по 40-й - в ending

pwned=$(curl -s "https://api.pwnedpasswords.com/range/$firstFive" | \
tr -d '\r' | grep -i "$ending" )    # Возвращаемый результат содержит как символы возврата 
                                    # каретки (\r), так и символы новой строки (\n)  
                                    # Удаляем символ возрата коретки 
                                    # Поиск результата ведется с помощью команды grep и символов хеша 
                                    # пароля, начиная с 6-го и заканчивая 40-м символом

passwordFound=${pwned##*:}          # Удаляем ведущий хеш, то есть все символы до двоеточия, 
                                    # включая сам символ двоеточия, чтобы узнать сколько раз был взломан пароль
                                    # хештег - самое длинное совпадение, * - шаблон, соответствует любым символам
if [ "$passwordFound" == "" ]
then
    exit 1
else
    printf 'Password is Pwned %d Times!\n' "$passwordFound"
    exit 0
fi
