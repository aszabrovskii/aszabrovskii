#!/bin/bash

#Memory usage statistics

KDATA_RE="K$"
MDATA_RE="M$"
GDATA_RE="G$"
TDATA_RE="T$"
PDATA_RE="P$"

DAEMON=kamailio

DATA=$(systemd-cgtop -n1 | grep $DAEMON | awk '{print $4}')

#--- Kilo
if [[ "$DATA" =~ $KDATA_RE ]]; then
   STR="${DATA::-1}"
   printf '%s\n' "$STR" | numfmt --from-unit=K

#--- Mega
elif [[ "$DATA" =~ $MDATA_RE ]]; then
   STR="${DATA::-1}"
   printf '%s\n' "$STR" | numfmt --from-unit=M

#--- Giga
elif [[ "$DATA" =~ $GDATA_RE ]]; then
   STR="${DATA::-1}"
   printf '%s\n' "$STR" | numfmt --from-unit=G

#--- Tera
elif [[ "$DATA" =~ $TDATA_RE ]]; then
   STR="${DATA::-1}"
   printf '%s\n' "$STR" | numfmt --from-unit=T

#--- Peta
elif [[ "$DATA" =~ $PDATA_RE ]]; then
   STR="${DATA::-1}"
   printf '%s\n' "$STR" | numfmt --from-unit=P

fi
