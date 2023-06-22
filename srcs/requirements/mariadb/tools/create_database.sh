#!bin/sh

# Creates the database
if [ ! -d "/var/lib/mysql/wordpress" ]; then

        cat << EOF > /tmp/create_database.sql
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE ${MYSQL_DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${MYSQL_DB_USER}'@'%' IDENTIFIED by '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DB_NAME}.* TO '${MYSQL_DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
        # Runs the create_database.sql script
        /usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_database.sql
        rm -f /tmp/create_database.sql
fi
