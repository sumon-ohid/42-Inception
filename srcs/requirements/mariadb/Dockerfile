FROM debian:bullseye

# Install MariaDB
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Copy MariaDB configuration and setup script
COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/data-setup.sh /usr/local/bin/data-setup.sh

# Run MariaDB setup script
RUN chmod +x /usr/local/bin/data-setup.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/data-setup.sh"]
