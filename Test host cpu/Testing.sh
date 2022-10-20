#!/bin/bash
#Shebang

#Тестовый скрипт, бесконечный ping в цикле, stdin показателей CPU при максимальной загрузке запросов на хост

case "$1" in
	n|N) 
		read -p "How many hits to use? " USER_COUNT
		read -p "Enter ip: " IP_ADDRES
		for number in $USER_COUNT
		do
			ping -c $USER_COUNT $IP_ADDRES
		done
		;;
	w|W)
		read -p "Enter ip: " IP_ADDRES
		read -p "Keypress. Is ${IP_ADDRES} correct ? "
			
		echo "$IP_ADDRES"
		COUNTER=0
		top -d 1 -n 3600 | grep "%Cpu(s):" > ./whileping.log & # stdout CPU &
		while [ "ping -c 1 $IP_ADDRES" ] 
			do
			echo "ping $IP_ADDRES in quantity: '$COUNTER'" 
			let COUNTER=COUNTER+1
			
		done
		echo "$IP_ADDRES down, continuing."
		mypid=$(ps -o pid= -p "$!")
		myppid=$(ps -o ppid= -p "$!")
		kill $mypid
		kill $myppid
		;;
	top)
		top -d 1 -n 3600 | grep "%Cpu(s):" > ./CPU.log | tail -f ./CPU.log
		;;	
	*)
		echo "Usage: $0 n - (ping for) | w - (ping while) | top" 
		;;
		
esac
