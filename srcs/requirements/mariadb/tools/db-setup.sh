#!/bin/sh

GREEN='\033[0;32m'
NC='\033[0m'

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo -e "${GREEN}Creating database...${NC}"
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	echo -e "${GREEN}Creating a temp dir to store data... ${NC}"
	temp_data=`mktemp`
	if [ ! -f "$temp_data" ]; then
		return 1
	fi

	echo -e "${GREEN}Creating users in database ...🙎🏻‍♂️🔐🙎🏻‍♂️🔐. ${NC}"
	cat << DELIM > $temp_data
	USE mysql;
	FLUSH PRIVILEGES;

	DELETE FROM	mysql.user WHERE User='';
	DROP DATABASE test;
	DELETE FROM mysql.db WHERE Db='test';
	DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

	ALTER USER 'root'@'localhost' IDENTIFIED BY '$DATABASE_ROOT_PASS';

	CREATE DATABASE $WP_DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
	CREATE USER '$WP_DB_USER'@'%' IDENTIFIED by '$WP_DB_PASS';
	GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'%';

	FLUSH PRIVILEGES;
DELIM
	/usr/bin/mysqld --user=mysql --bootstrap < $temp_data
fi

echo -e "${GREEN}Modifying mariadb-server.cng file$.... ${NC}"
sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

echo -e "${GREEN}Starting mariadb server... 🗄️ 🌐 ✅${NC}"
exec /usr/bin/mysqld --user=mysql --console
