#!/bin/bash

# Shebang

# Шифрую сценарий с помощью sha512 алгоритма хеширования
case "$1" in
    encr)
            openssl enc -aes-256-cbc -md sha512 -a -pbkdf2 -iter 100000 -salt -in cpu.sh -out \
            indecode_2.enc -pass pass:secret  # Шифруемый файл cpu.sh
            ;;                                # Зашифрованный текст в indecode_2.enc

    dec)
            #2  Decoding #password: secret 

            encrypted='U2FsdGVkX1/vm3QjTV6NiNQrT3o1yY4uX9n2oc5LLS8yWmT1U/mPg6P3H9owX14D
            Hc3Xrr1QX55SJWLWX8KoPg==' 
            read -s word # ключ -s позволяет вводить пароль без вывода на экран  

            innerScript=$(echo "$encrypted" | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -salt -pass pass:"$word")
            eval "$innerScript"
            ;;
    *)
    		echo "Usage: $0 encr - (encryption, sha512) | dec - (decoding)"
            ;;        
esac
