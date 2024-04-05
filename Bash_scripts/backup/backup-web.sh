#!/bin/sh
### System Setup ###
BACKUP=/home/ubuntu/script_backup
SOURCE=/data/vhosts/domain.com/staging.domain.com
### FTP ###
FTPD="/SH_Backups/domain.com/"
FTPU="user"
FTPP='password'
FTPS="192.168.155.253"

### Binaries ###
TAR="$(which tar)"
#GZIP="$(which gzip)"
FTP="$(which ftp)"

## Today + hour in 24h format ###
NOW=$(date +%Y%m%d)

### Create tmp dir ###

mkdir $BACKUP/$NOW
$TAR -cf $BACKUP/$NOW/staging.$NOW.domain.tar $SOURCE

### Save to local ###
#ARCHIVE=$BACKUP/server-$NOW.tar.gz
#ARCHIVED=$BACKUP/$NOW

#$TAR -zcvf $ARCHIVE $ARCHIVED

### ftp ###
cd $BACKUP/$NOW
DUMPFILE=staging.$NOW.domain.tar 
$FTP -n $FTPS <<END_SCRIPT
quote USER $FTPU
quote PASS $FTPP
cd $FTPD
mput $DUMPFILE
quit
END_SCRIPT

### clear ###
rm -rf $BACKUP/$NOW
