#!/bin/sh
set -e

if [ "${1#-}" != "$1" ]; then
  set -- php-fpm "$@"
fi

if [ "$1" = 'php-fpm' ] || [ "$1" = 'php' ]; then

  # Cache everything
  php artisan optimize
  php artisan config:cache
  php artisan route:cache
  php artisan view:cache
  php artisan event:cache
#  php artisan ziggy:generate

fi

exec "$@" &
exec nginx
exec crond
exec supervisord --configuration /etc/supervisord.conf