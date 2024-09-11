FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=AT/ST=Vienna/L=Vienna/O=42/OU=42/CN=localhost"

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

RUN mkdir -p /var/run/nginx

RUN sed -i "s/my_cert/$ssl_certificate/g" /etc/nginx/sites-available/default
RUN sed -i "s/my_key/$ssl_certificate_key/g" /etc/nginx/sites-available/default
RUN sed -i "s/DOMAIN_NAME/$nginx_domain/g" /etc/nginx/sites-available/default   

CMD ["nginx", "-g", "daemon off;"]
