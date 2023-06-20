FROM alpine:3.16

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
    php8 \
    php8-fpm \
    php8-mysqli \
    php8-json \
    php8-openssl \
    php8-curl \
    php8-zlib \
    php8-xml \
    php8-phar \
    php8-intl \
    php8-dom \
    php8-xmlreader \
    php8-ctype \
    php8-mbstring \
    php8-gd \
    php8-session \
    php8-iconv \
    php8-simplexml \
    php8-tokenizer \
    php8-xmlwriter \
    php8-fileinfo \
    php8-xmlreader \
    php8-exif \
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
# COPY php-fpm.conf /etc/php8/php-fpm.conf

# Creates wordpress configuration
WORKDIR /var/www/wordpress
RUN cp ./wp-config-sample.php ./wp-config.php
RUN sed -i "s|database_name_here|$MYSQL_DB_NAME|g" ./wp-config.php && \
    sed -i "s|username_here|$MYSQL_DB_USER|g" ./wp-config.php && \
    sed -i "s|localhost|mariadb|g" ./wp-config.php && \
    sed -i "s|password_here|$MYSQL_ROOT_PASSWORD|g" ./wp-config.php


COPY ./requirements/wordpress/tools/install.sh .
RUN chmod +x install.sh && \
    sed -i "s|domain_name_here|$DOMAIN_NAME|g" install.sh && \
    sed -i "s|wordpress_admin_user_here|$WORDPRESS_ADMIN_USER|g" install.sh && \
    sed -i "s|wordpress_admin_password_here|$WORDPRESS_ADMIN_PASSWORD|g" install.sh && \
    sed -i "s|wordpress_admin_email_here|$WORDPRESS_ADMIN_EMAIL|g" install.sh

# Expose the communication port
# netstat -tulpn | grep LISTEN
EXPOSE 9000

# Start PHP-FPM
CMD ["sh", "-c", "./install.sh && /usr/sbin/php-fpm8 -F"]
