#!/bin/sh

# This script needs to get the values replaced before being able to run it.
# Check all the ???_here values and replace them with proper values
wp core install --path=/var/www/wordpress --url=domain_name_here \
    --title="42 inception" \
    --admin_name=wordpress_admin_user_here \
    --admin_user=wordpress_admin_user_here \
    --admin_password=wordpress_admin_password_here \
    --admin_email=wordpress_admin_email_here \
    --skip-email --allow-root

# Runs the php command passed as a parameter from Dockerfile
exec "$@"