#!/bin/bash

set -euo pipefail

if [ ! -f /opt/rt4_data/etc/RT_SiteConfig.pm ]; then
  cd /opt
  cp rt4/* rt4_data/
  rm -rf rt4
  ln -s /opt/rt4_data rt4
fi

: "${RT_WEB_PORT:=80}"

RT_WEB_URL="${RT_WEB_URL//\//\\/}"

sed -i "s/RT_WEB_PORT/$RT_WEB_PORT/" /opt/rt4_data/etc/RT_SiteConfig.pm
sed -i "s/RT_WEB_URL/$RT_WEB_URL/" /opt/rt4_data/etc/RT_SiteConfig.pm

chown -R www-data:www-data /opt/rt4_data/

exec "$@"
