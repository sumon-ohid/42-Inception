-- Delete anonymous users
DELETE FROM mysql.user WHERE User='';

-- Drop the test database
DROP DATABASE IF EXISTS test;

-- Remove privileges on the test database
DELETE FROM mysql.db WHERE Db='test';

-- Remove remote root access
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

-- Set root password
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${DB_ROOT_PASSWORD}');

-- Create a new database
CREATE DATABASE ${DB_NAME};

-- Create a new user
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';

-- Grant all privileges to the new user on the new database
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';

-- Apply changes
FLUSH PRIVILEGES;
