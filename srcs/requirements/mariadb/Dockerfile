FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nano \    
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld && \
    mkdir -p /var/lib/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysqld && \
    chmod 777 /var/run/mysqld

COPY ./conf/my.cnf /etc/my.cnf.d/
COPY ./conf/wp_data.sql /tmp/wp_data.sql
COPY ./tools/data-setup.sh /usr/local/bin/data-setup.sh

RUN chmod +x /usr/local/bin/data-setup.sh
RUN mariadb-install-db --datadir=/var/lib/mysql --user=mysql \
    --auth-root-authentication-method=normal

EXPOSE 3306

ENTRYPOINT ["data-setup.sh"]