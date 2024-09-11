cat .setup 2> /dev/null

echo "CREATE DATABASE --->> $DB_NAME <<<---;"
if [ $? -ne 0 ]; then
	usr/bin/mysqld_safe --datadir=/var/lib/mysql &
	while ! mysqladmin ping -h "$DB_HOSTNAME" --silent; do
    	sleep 1
	done

	eval "echo \"$(cat /tmp/create_db.sql)\"" | mariadb
	touch .setup
fi
usr/bin/mysqld_safe --datadir=/var/lib/mysql
