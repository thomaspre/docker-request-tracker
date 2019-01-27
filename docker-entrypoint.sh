#!/bin/bash

set -euo pipefail

cd /opt

if [ ! -d "/opt/rt4_data/var/" ]; then  
  mkdir rt4_data/var/
  cp -r rt4/var/* rt4_data/var/ 
fi

rm -rf rt4/var
ln -s /opt/rt4_data/var rt4/var

: "${RT_WEB_PORT:=80}"

RT_WEB_URL="${RT_WEB_URL//\//\\/}"

sed -i "s/RT_WEB_PORT/$RT_WEB_PORT/" /opt/rt4/etc/RT_SiteConfig.pm
sed -i "s/RT_WEB_URL/$RT_WEB_URL/" /opt/rt4/etc/RT_SiteConfig.pm

chown -R www-data:www-data /opt/rt4_data

echo "---- ls opt"
ls -al /opt/rt4/
ls -al /opt/rt4_data/
ls -al /opt/rt4_data/var/

exec "$@"
