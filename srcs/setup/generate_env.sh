#!/bin/sh

# Generate secure random passwords
MYSQL_ROOT_PASSWORD_SECRET=$(openssl rand -base64 20)
MYSQL_PASSWORD=$(openssl rand -base64 20)
WORDPRESS_ADMIN_PASSWORD=$(openssl rand -base64 20)

# Duplicate the template file
cp ../.env.example ../.env

echo "MYSQL_ROOT_PASSWORD_SECRET = $MYSQL_ROOT_PASSWORD_SECRET"
echo "MYSQL_PASSWORD_SECRET = $MYSQL_PASSWORD"
echo "WORDPRESS_ADMIN_PASSWORD_SECRET = $WORDPRESS_ADMIN_PASSWORD"

# Replace the marker with the generated password in the .env file
sed -i '' "s;MYSQL_ROOT_PASSWORD_SECRET;$MYSQL_ROOT_PASSWORD_SECRET;g" ../.env
sed -i '' "s;MYSQL_PASSWORD_SECRET;$MYSQL_PASSWORD;g" ../.env
sed -i '' "s;WORDPRESS_ADMIN_PASSWORD_SECRET;$WORDPRESS_ADMIN_PASSWORD;g" ../.env
