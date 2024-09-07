# Use a stable version of Debian as the base image
FROM debian:bullseye

# Install MariaDB
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Create necessary directories and set permissions
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

# Copy configuration file
COPY my.cnf /etc/mysql/my.cnf

# Expose the port MariaDB runs on
EXPOSE 3306

# Start MariaDB
CMD ["mysqld_safe"]
