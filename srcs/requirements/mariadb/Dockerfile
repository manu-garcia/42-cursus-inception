FROM alpine:3.17

# Makes this env variables available in the container
ARG MYSQL_DB_NAME
ARG MYSQL_DB_USER
ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_PASSWORD

# Checking env values
RUN echo "MYSQL_DB_NAME = $MYSQL_DB_NAME"
RUN echo "MYSQL_DB_USER = $MYSQL_DB_USER"
RUN echo "MYSQL_ROOT_PASSWORD = $MYSQL_ROOT_PASSWORD"
RUN echo "MYSQL_PASSWORD = $MYSQL_PASSWORD"

RUN apk update && apk add --no-cache mariadb mariadb-client

# Creates needed directories and sets user priviledges
RUN mkdir -p /run/mysqld
RUN chown -R "$MYSQL_DB_USER:$MYSQL_DB_USER" /run/mysqld

RUN mkdir -p /var/lib/mysql
RUN chown -R "$MYSQL_DB_USER:$MYSQL_DB_USER" /var/lib/mysql

RUN mysql_install_db --user="$MYSQL_DB_USER" --datadir=/var/lib/mysql

# Allows external networking
RUN sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
RUN sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

# Create the database
COPY requirements/mariadb/tools/create_database.sh .
RUN sh create_database.sh && rm create_database.sh

EXPOSE 3306

CMD /usr/bin/mysqld --user=mysql

