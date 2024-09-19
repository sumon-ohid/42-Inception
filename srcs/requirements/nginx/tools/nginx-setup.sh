#!/bin/sh

GREEN='\033[0;32m'
NC='\033[0m'

echo "${GREEN}Creating a self-signed SSL certificate...${NC}"
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/selfsigned-ssl.pem \
        -keyout /etc/nginx/ssl/selfsigned-ssl.key \
        -subj "/C=AT/ST=Vienna/L=Vienna/O=42 School/OU=msumon/CN=${USERNAME}.42.fr/"

nginx -g 'daemon off;'
