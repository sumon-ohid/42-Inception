# Use Debian as the base image
FROM debian:bullseye

# Install NGINX and OpenSSL
RUN apt-get update && apt-get install -y \
    nginx \
    curl \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Copy NGINX configuration and SSL certificates
COPY nginx.conf /etc/nginx/nginx.conf
COPY ssl /etc/nginx/ssl

# Expose port 443 for HTTPS
EXPOSE 443

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
