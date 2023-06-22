FROM alpine:3.17

# Makes this env variables available in the container
ARG MYSQL_DB_NAME
ARG MYSQL_DB_USER
ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_PASSWORD
ARG DOMAIN_NAME
ARG WORDPRESS_ADMIN_USER
ARG WORDPRESS_ADMIN_PASSWORD
ARG WORDPRESS_ADMIN_EMAIL

# Checking env values
RUN echo "MYSQL_DB_NAME = $MYSQL_DB_NAME"
RUN echo "MYSQL_DB_USER = $MYSQL_DB_USER"
RUN echo "MYSQL_ROOT_PASSWORD = $MYSQL_ROOT_PASSWORD"
RUN echo "MYSQL_PASSWORD = $MYSQL_PASSWORD"
RUN echo "DOMAIN_NAME = $DOMAIN_NAME"
RUN echo "WORDPRESS_ADMIN_USER = $WORDPRESS_ADMIN_USER"
RUN echo "WORDPRESS_ADMIN_EMAIL = $WORDPRESS_ADMIN_EMAIL"
RUN echo "WORDPRESS_ADMIN_PASSWORD = $WORDPRESS_ADMIN_PASSWORD"

# Install PHP, WordPress, and other required dependencies
RUN	apk update && apk upgrade && apk add --no-cache  \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-json \
    php81-openssl \
    php81-curl \
    php81-zlib \
    php81-xml \
    php81-phar \
    php81-intl \
    php81-dom \
    php81-xmlreader \
    php81-ctype \
    php81-mbstring \
    php81-gd \
    php81-session \
    php81-iconv \
    php81-simplexml \
    php81-tokenizer \
    php81-xmlwriter \
    php81-fileinfo \
    php81-xmlreader \
    php81-exif \
    curl \
    wget \
    unzip

# Download and extract WordPress
WORKDIR /var/www

# Set up permissions
RUN chmod -R 755 /var/www

# Installs latest wordpress
ADD https://wordpress.org/latest.tar.gz ./wordpress.tar.gz
RUN tar -xzf ./wordpress.tar.gz -C /var/www/ \
    && rm ./wordpress.tar.gz

# Installs the wordpress command line client
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

# Copy the custom PHP-FPM configuration
# COPY php-fpm.conf /etc/php81/php-fpm.conf
RUN sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php81/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php81/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php81/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

# Creates wordpress configuration
WORKDIR /var/www/wordpress
RUN cp ./wp-config-sample.php ./wp-config.php
RUN sed -i "s|database_name_here|$MYSQL_DB_NAME|g" ./wp-config.php && \
    sed -i "s|username_here|$MYSQL_DB_USER|g" ./wp-config.php && \
    sed -i "s|localhost|mariadb|g" ./wp-config.php && \
    sed -i "s|password_here|$MYSQL_PASSWORD|g" ./wp-config.php

COPY ./requirements/wordpress/tools/install.sh .
RUN chmod +x install.sh && \
    sed -i "s|domain_name_here|$DOMAIN_NAME|g" install.sh && \
    sed -i "s|wordpress_admin_user_here|$WORDPRESS_ADMIN_USER|g" install.sh && \
    sed -i "s|wordpress_admin_password_here|$WORDPRESS_ADMIN_PASSWORD|g" install.sh && \
    sed -i "s|wordpress_admin_email_here|$WORDPRESS_ADMIN_EMAIL|g" install.sh

# Expose the communication port
EXPOSE 9000

# Start PHP-FPM
CMD ["sh", "-c", "./install.sh && /usr/sbin/php-fpm81 -F"]
