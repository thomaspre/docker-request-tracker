#!/bin/bash

set -euo pipefail

ls -al /opt/
cd /opt

if [ ! -d "/opt/rt4_data/var/" ]; then

  echo "---- ls rt4"
  ls -al rt4/
  
  mkdir rt4_data/var/
  cp -r rt4/var/* rt4_data/var/
  
  echo "---- ls rt4_data"
  ls -al rt4_data/
  ls -al rt4_data/var/
  
fi

rm -rf rt4/var
ln -s /opt/rt4_data/var rt4/var
  
echo "---- ls opt"
ls -al /opt/rt4/

: "${RT_WEB_PORT:=80}"

RT_WEB_URL="${RT_WEB_URL//\//\\/}"

sed -i "s/RT_WEB_PORT/$RT_WEB_PORT/" /opt/rt4/etc/RT_SiteConfig.pm
sed -i "s/RT_WEB_URL/$RT_WEB_URL/" /opt/rt4/etc/RT_SiteConfig.pm

chown -R www-data:www-data /opt/rt4_data

apache2-foreground

exec "$@"
