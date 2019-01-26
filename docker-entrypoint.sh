#!/bin/bash

set -euo pipefail

ls -al /opt/

if [ ! -f "/opt/rt4_data/etc/RT_SiteConfig.pm" ]; then
  cd /opt
  echo "rt4:"
  ls rt4/
  cp -r rt4/* rt4_data/
  echo "rt4_data:"
  ls rt4_data/
  rm -rf rt4
  ln -s /opt/rt4_data rt4
fi

ls -al /opt/

: "${RT_WEB_PORT:=80}"

RT_WEB_URL="${RT_WEB_URL//\//\\/}"

sed -i "s/RT_WEB_PORT/$RT_WEB_PORT/" /opt/rt4_data/etc/RT_SiteConfig.pm
sed -i "s/RT_WEB_URL/$RT_WEB_URL/" /opt/rt4_data/etc/RT_SiteConfig.pm

chown -R www-data:www-data /opt/rt4_data/

exec "$@"
