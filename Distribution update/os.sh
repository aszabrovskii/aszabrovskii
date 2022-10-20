#!/bin/bash
#Shebang
#Данный скрипт пробный. Он предназначен, для обновления дистрибутива и инсталляции выбранных пакетов

source lib.sh #Импорт библиотеки с данными репозиториев

function building() {  #данная функция вычисляет наименование дистрибутива с вытекающими аргументами

distrib="Debian" #Название требуемого дистрибутива, для сравнения строк из запроса info
info="$(which hostnamectl | awk '{print $3}'| head -n 6 | tail -n 1)" #определяет расположение hoctnamectl вычисление строк дистрибутива из команды hostnamectl
if [[ $EUID -ne 0 ]]; then #EUID определяет наличие идентификатора root равное нулю, если идентификатор не равен 0, условие требует права root и завершает скрипт
	echo "Требуются права администратора, запустите скрипт от имени root" #stdout на экран пользователя
exit 0
else			
	if [[ $distrib != $info ]] && [[ $? == 0 ]]; then #условие не равенства переменной distrib с вычисляемой info && 
		 #Если предыдущее условие верно, возвращает 0 (true), означая что предыдущее выражение истинно. 
        echo "Это не дистрибутив Debian !"
		echo "Перед установкой будет изменен GPG ключ репозитория $info на Debian ..."
		read -p "Вы согласны с условиями ? (y/n) = " Keypress #stdin, предлагает пользователю выбор. Если  stdin = n, следующее условие завершает скрипт, иначе продолжает.
			if [ "$Keypress" = "n" ]; then #условие сравнения, если stdin = n, завершает скрипт
			exit 1	 #уничтожает процесс выполнения
			else
			directory="/home/$USER/backup_gpg_$(date +%F)" #сценарий. Значение переменной, для текущего пользователя с текущей датой на момент выполнения
			mkbackup=$(which | mkdir -p $directory) #сценарий. (создает дерево каталогов)
			kastom="/etc/apt/trusted.gpg.d"	#значение. Дирректория исходных ключей
			echo "Создан каталог: $directory $mkbackup" #stdout переменных на экран пользователя
			echo "Выполнен BACKUP gpg ключей Ubuntu $backupв дирректорию $directory" #stdout переменных на экран пользователя
			echo $(which | cp /usr/share/keyrings/* $directory) #сценарий выполнения Shebang (копирование) gpg ключей
				if [[ $? == 0 ]]; then #Если предыдущее выражени верно, возвращает 0 (true), выражение истинно.
				echo " Ключи скопированы !" #stdout переменных на экран пользователя
				echo " cp /usr/share/keyrings/* $directory" #stdout переменных на экран пользователя
				for list in $(which | ls -ls $directory | awk '{print $10}') #Построчный цикл stdout каталога с скопированными ключами gpg 
				do
				echo " $list" #вывод содержимого каталога на экран пользователя
				done
				echo
				echo " Заменяю GPG ключи $info на Debian" #stdout переменных на экран пользователя
				echo " $kastom" #stdout переменных на экран пользователя
				sleep 1 #Искусственное удержания процесса)
				echo $(cp /usr/share/keyrings/* /etc/apt/trusted.gpg.d) #сценарий выполнения Shebang (копирование)
					if [[ $? == 0 ]]; then #
					for list in $(which | ls -ls $directory | awk '{print $10}') #Цикл stdout скопированных данных
					do
					echo " $list" #
					done
					echo
					echo "Замена произведена !"
					else
					echo "Замена не произведена !"
					fi
                reink_distr    #вызов функции в импортированной библиотеке lib.sh (Данные репозиториев)
                fi
            fi
        
	else
	echo "*** Это дистрибутив Debian, репозитории остаются прежними. ***"
    fi
fi
}

function packet() {  #функция packet устанавливает пакеты bash gawk sed со всеми зависимыми библиотеками.
apt update #Обновляет актуальную базу данных с доступными пакетами
apt install -y bash gawk sed #Установка пакетов с зависимостями, включает -f для исправления возможной ошибки во время установки пакетов
apt show bash gawk sed | grep -i APT-Sources #Просматриваю информацию о пакете, источник репозиториев установки
apt show bash gawk sed | grep -i pre-Depends #Просматриваю информацию о пакете, от каких пакетов зависит
} 


building #Вызов функции building
packet   #Вызов функции packet 