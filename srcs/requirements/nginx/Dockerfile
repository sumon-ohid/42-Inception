FROM debian:bullseye

# Install NGINX and necessary tools
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Copy NGINX configuration
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/nginx.conf /etc/nginx/sites-available/default
COPY ./conf/ssl/ /etc/ssl/

EXPOSE 80 443

# Ensure NGINX runs in the foreground
CMD ["nginx", "-g", "daemon off;"]

