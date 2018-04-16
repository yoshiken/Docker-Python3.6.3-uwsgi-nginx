#!/bin/sh

/usr/sbin/nginx -c /etc/nginx/nginx.conf
cd /var/www/html/app
chmod -R 777 .
uwsgi --ini uwsgi.ini

echo 'Complete!! Enjoy!! :)'
