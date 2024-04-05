#!/bin/bash
# Creating certificates and keys for the following hosts
# Search for generated certificates
# renaming keys and certificates
# to be delivered to the server

#Run the script with root privileges
RED='\033[0;31m'
GREEN='\e[32m'
YELLOW='\e[33m'	
NOCOLOR='\033[0m'

echo "Create certificates for the following hosts"
echo "host-site-api.domain.com"
echo "host-site.domain.com"
echo "hoster-demo.domain.com"
# Example message

# How would you like to authenticate with the ACME CA?
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 1: Nginx Web Server plugin (nginx)
# 2: Spin up a temporary webserver (standalone)
# 3: Place files in webroot directory (webroot)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Select the appropriate number [1-3] then [enter] (press 'c' to cancel): 3
# Plugins selected: Authenticator webroot, Installer None
# Obtaining a new certificate

echo "Please enter the number 3"
certbot --duplicate certonly -w /home/domain/certbot -d host-site-api.domain.com
certbot --duplicate certonly -w /home/domain/certbot -d host-site.domain.com
certbot --duplicate certonly -w /home/domain/certbot -d hoster-demo.domain.com
echo "Congratulations Certificates for hosts successfully created"

# Search created directories. Passing values into variables
echo "Catalog Search "
host=$(find /etc/letsencrypt/archive -name host-site.domain.com-[0-9][0-9][0-9][0-9]*)
host_api=$(find /etc/letsencrypt/archive -name host-site-api.domain.com-[0-9][0-9][0-9][0-9]*)
hoster=$(find /etc/letsencrypt/archive -name hoster-demo.domain.com-[0-9][0-9][0-9][0-9]*)
#-----------
echo "Moves the created directories"
mv $host /home/domain/certbot/Certificate-folders/ 2>/dev/null
if [ "$?" -eq "0" ]; then echo -e "${GREEN}Successfully moved host-site.domain.com${NOCOLOR}"; else echo -e "${RED}Error${NOCOLOR}"; fi
mv $host_api /home/domain/certbot/Certificate-folders/ 2>/dev/null
if [ "$?" -eq "0" ]; then echo -e "${GREEN}Successfully moved host-site-api.domain.com${NOCOLOR}"; else echo -e "${RED}Error${NOCOLOR}"; fi
mv $hoster  /home/domain/certbot/Certificate-folders/ 2>/dev/null
if [ "$?" -eq "0" ]; then echo -e "${GREEN}Successfully moved hoster-demo.domain.com${NOCOLOR}"; else echo -e "${RED}Error${NOCOLOR}"; fi
echo
# Renaming Certificates
# host-site.domain.com
echo "Renaming a certificate for a host host-site.domain.com"

echo "Enter the name of the last certificate referenced by the host"
echo
read -p "fullchain and privkey " host_rename
echo -e "Created ${YELLOW}fullchain$host_rename.pem privkey$host_rename.pem${NOCOLOR}"

echo "Renaming a certificate for a host host-site.domain.com"
host_site=$(find /home/domain/certbot/Certificate-folders/host-site.domain.com-[0-9][0-9][0-9][0-9]*/fullchain*.pem 2>/dev/null)
if [ "$?" -eq "0" ]; then echo -e "${GREEN}Сertificate found${NOCOLOR}"; else echo -e "${RED}Search error${NOCOLOR}"; fi
cp $host_site /home/domain/certbot/Ready_certificates/host-site.domain.com/fullchain$host_rename.pem 2>/dev/null
if [ "$?" -eq "0" ]; then echo -e "${GREEN}Successfully renamed${NOCOLOR}"; else echo -e "${RED}Rename error${NOCOLOR}"; fi

# host-site-api.domain.com
echo "Renaming a certificate for a host host-site-api.domain.com"
host_api=$(find /home/domain/certbot/Certificate-folders/host-site-api.domain.com-[0-9][0-9][0-9][0-9]*/fullchain*.pem 2>/dev/null)
if [ "$?" -eq "0" ]; then echo -e "${GREEN}Сertificate found${NOCOLOR}"; else echo -e "${RED}Search error${NOCOLOR}"; fi
cp $host_api /home/domain/certbot/Ready_certificates/host-site-api.domain.com/fullchain$host_rename.pem 2>/dev/null
if [ "$?" -eq "0" ]; then echo -e "${GREEN}Successfully renamed${NOCOLOR}"; else echo -e "${RED}Rename error${NOCOLOR}"; fi

# hoster-demo.domain.com
echo "Renaming a certificate for a host hoster-demo.domain.com"
hoster=$(find /home/domain/certbot/Certificate-folders/hoster-demo.domain.com-[0-9][0-9][0-9][0-9]*/fullchain*.pem 2>/dev/null)
if [ "$?" -eq "0" ]; then echo -e "${GREEN}Сertificate found${NOCOLOR}"; else echo -e "${RED}Search error${NOCOLOR}"; fi
cp $hoster /home/domain/certbot/Ready_certificates/hoster-demo.domain.com/fullchain$host_rename.pem 2>/dev/null
if [ "$?" -eq "0" ]; then echo -e "${GREEN}Successfully renamed${NOCOLOR}"; else echo -e "${RED}Rename error${NOCOLOR}"; fi
#------------
# Renaming Keys
# host-site.domain.com
echo "Renaming a certificate for a host host-site.domain.com"
host_site=$(find /home/domain/certbot/Certificate-folders/host-site.domain.com-[0-9][0-9][0-9][0-9]*/privkey*.pem 2>/dev/null)
if [ "$?" -eq "0" ]; then echo -e "${GREEN}Key found${NOCOLOR}"; else echo -e "${RED}Search error${NOCOLOR}"; fi
cp $host_site /home/domain/certbot/Ready_certificates/host-site.domain.com/privkey$host_rename.pem 2>/dev/null
if [ "$?" -eq "0" ]; then echo -e "${GREEN}Successfully renamed${NOCOLOR}"; else echo -e "${RED}Rename error${NOCOLOR}"; fi

# host-site-api.domain.com
echo "Renaming a certificate for a host host-site-api.domain.com"
host_api=$(find /home/domain/certbot/Certificate-folders/host-site-api.domain.com-[0-9][0-9][0-9][0-9]*/privkey*.pem 2>/dev/null)
if [ "$?" -eq "0" ]; then echo -e "${GREEN}Key found${NOCOLOR}"; else echo -e "${RED}Search error${NOCOLOR}"; fi
cp $host_api /home/domain/certbot/Ready_certificates/host-site-api.domain.com/privkey$host_rename.pem 2>/dev/null
if [ "$?" -eq "0" ]; then echo -e "${GREEN}Successfully renamed${NOCOLOR}"; else echo -e "${RED}Rename error${NOCOLOR}"; fi

# hoster-demo.domain.com
echo "Renaming a certificate for a host hoster-demo.domain.com"
hoster=$(find /home/domain/certbot/Certificate-folders/hoster-demo.domain.com-[0-9][0-9][0-9][0-9]*/privkey*.pem 2>/dev/null)
if [ "$?" -eq "0" ]; then echo -e "${GREEN}Key found${NOCOLOR}"; else echo -e "${RED}Search error${NOCOLOR}"; fi
cp $hoster /home/domain/certbot/Ready_certificates/synchrony-demo.domain.com/privkey$host_rename.pem 2>/dev/null
if [ "$?" -eq "0" ]; then echo -e "${GREEN}Successfully renamed${NOCOLOR}"; else echo -e "${RED}Rename error${NOCOLOR}"; fi

