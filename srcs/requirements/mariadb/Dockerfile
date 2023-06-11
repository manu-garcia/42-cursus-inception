FROM alpine:3.16

RUN apk update && apk add --no-cache mariadb mariadb-client

EXPOSE 3306

CMD ["/usr/bin/mysqld"]