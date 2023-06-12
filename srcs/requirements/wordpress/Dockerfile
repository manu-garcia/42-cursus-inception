FROM alpine:3.16

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
ADD https://wordpress.org/latest.tar.gz ./wordpress.tar.gz
RUN tar -xzf ./wordpress.tar.gz -C /var/www/ \
    && rm ./wordpress.tar.gz

# Copy the custom PHP-FPM configuration
# COPY php-fpm.conf /etc/php8/php-fpm.conf

# Set up permissions
# RUN chown -R nginx:nginx /var/www/wordpress \
#     && chmod -R 755 /var/www/wordpress

# Expose the default HTTP port
EXPOSE 80

# Start PHP-FPM
CMD ["sh", "-c", "/usr/sbin/php-fpm8 -F"]
