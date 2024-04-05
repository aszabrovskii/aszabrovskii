#!/bin/sh
#Each base is uploaded to a separate file.

# System + MySQL backup script
### System Setup ###
BACKUP=/root/backup/mysql

### Mysql ### [access parameters to our MySQL databases]
MUSER="root"
MPASS="megapassword"
MHOST="localhost"

### FTP ###
FTPD="/"
FTPU="username" [user name (login) remote ftp-server]
FTPP="megapassword" [access password access ftp-server]
FTPS="my_remote_backup.ru" [address ftp-server or her IP]

### Binaries ###
TAR="$(which tar)"
GZIP="$(which gzip)"
FTP="$(which ftp)"
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"

## Today + hour in 24h format ###
NOW=$(date +%Y%m%d)

### Create temp dir ###

mkdir $BACKUP/$NOW

### name Mysql ###
DBS="$($MYSQL -u $MUSER -h $MHOST -p$MPASS -Bse 'show databases')"
for db in $DBS
do

### ###
mkdir $BACKUP/$NOW/$db
FILE=$BACKUP/$NOW/$db/$db.sql.gz
echo $i; $MYSQLDUMP --add-drop-table --allow-keywords -q -c -u $MUSER -h $MHOST -p$MPASS $db $i | $GZIP -9 > $FILE
done

ARCHIVE=$BACKUP/mysql-$NOW.tar.gz
ARCHIVED=$BACKUP/$NOW

$TAR -zcvf $ARCHIVE $ARCHIVED

### ftp ###
cd $BACKUP
DUMPFILE=mysql-$NOW.tar.gz
$FTP -n $FTPS <<END_SCRIPT
quote USER $FTPU
quote PASS $FTPP
cd $FTPD
mput $DUMPFILE
quit
END_SCRIPT

### clear ###

rm -rf $ARCHIVED
