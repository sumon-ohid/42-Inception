FROM alpine:3.19

RUN apk update
RUN apk upgrade
RUN apk add --no-cache --quiet --update nginx openssl
RUN rm -rf /var/cache/apk/*

RUN mkdir /etc/nginx/ssl
COPY tools/nginx-setup.sh /home/nginx-setup.sh
RUN chmod +x /home/nginx-setup.sh
RUN mkdir -p /run/nginx
COPY conf/nginx.conf /etc/nginx/http.d/default.conf

ENTRYPOINT ["sh", "/home/nginx-setup.sh"]
