FROM debian:bullseye

RUN apt update; \
    apt install -y nginx openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \ 
    -keyout /etc/ssl/private/msumon.key \
    -out /etc/ssl/certs/msumon.crt \
    -subj="/C=AT/ST=Vienna/L=Vienna/O=42 School/OU=msumon/CN=msumon.42.fr"

COPY ./tools/certs.sh /tmp/certs.sh

RUN chmod +x /tmp/certs.sh

COPY ./conf/default /etc/nginx/sites-available/default


ENTRYPOINT ["/tmp/certs.sh"]