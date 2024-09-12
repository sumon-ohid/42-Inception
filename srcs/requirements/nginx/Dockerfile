FROM alpine:3.19

RUN apk update
RUN apk upgrade
RUN apk add --no-cache --quiet --update nginx openssl

RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/sumon.pem \
        -keyout /etc/nginx/ssl/sumon.key \
        -subj "/C=AT/ST=Vienna/L=Vienna/O=42 School/OU=sumon/CN=sumon/"

RUN mkdir -p /run/nginx
COPY conf/nginx.conf /etc/nginx/http.d/default.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]
