#!/bin/bash

# Environment variables
DB_ROOT_PASSWORD=${DB_ROOT_PASSWORD:-root}
DB_NAME=${DB_NAME:-wordpress}
DB_USER=${DB_USER:-user}
DB_PASSWORD=${DB_PASSWORD:-password}

# Initialize MariaDB if not already initialized
if [ ! -f /var/lib/mysql/.setup ]; then
    /usr/bin/mysqld_safe --datadir=/var/lib/mysql &
    sleep 10
    mysql -u root <<-EOSQL
        DELETE FROM mysql.user WHERE User='';
        DROP DATABASE IF EXISTS test;
        DELETE FROM mysql.db WHERE Db='test';
        DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
        CREATE DATABASE $DB_NAME;
        CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
        GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
        FLUSH PRIVILEGES;
        ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
    EOSQL
    touch /var/lib/mysql/.setup
fi

exec /usr/bin/mysqld_safe --datadir=/var/lib/mysql
