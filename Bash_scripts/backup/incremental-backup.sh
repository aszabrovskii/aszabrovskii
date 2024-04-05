#!/bin/sh

REMOTE_ADDR='user@storage:/remote_path'
MOUNTPOINT='/backup_remote'
BACKUP_DIR='/somedir'
MAILFROM='root@server'
MAILTO='mail@example.com'
EXPIRE="1W"

TMP='/tmp/backup_tmp.tmp'

sshfs $REMOTE_ADDR $MOUNTPOINT > /dev/null 2>&1

if [ `mount | grep $MOUNTPOINT | grep -vc grep` = "0" ]; then
    echo "Error mounting $MOUNTPOINT at `date +'%d/%m/%Y %H:%M'`" | mail -a "From: $MAILFROM" -s "Backup ERROR" $MAILTO
    exit 1
fi

if [ ! -d $MOUNTPOINT/$BACKUP_DIR ]; then
    mkdir -p $MOUNTPOINT/$BACKUP_DIR > /dev/null 2>&1
fi

printf "Processing $BACKUP_DIR... \n\n" >> $TMP
rdiff-backup --force --exclude-symbolic-links --exclude-sockets --exclude-special-files --exclude-fifos --exclude-device-files --no-hard-links --print-statistics $BACKUP_DIR $MOUNTPOINT/$BACKUP_DIR >> $TMP 2>&1
rdiff-backup --force --no-hard-links --remove-older-than $EXPIRE $MOUNTPOINT/$BACKUP_DIR >> $TMP 2>&1
printf "\n-----------------------\n\n" >> $TMP

ERRORS="no errors"

if [ `cat $TMP | grep 'Error' | grep -v 'Errors 0' | grep -cv grep` != "0" ]; then
    ERRORS="errors detected"
fi

cat $TMP | mail -a "From: $MAILFROM" -s "Backup report (${ERRORS})" $MAILTO
rm -f $TMP
umount $MOUNTPOINT

exit 0
