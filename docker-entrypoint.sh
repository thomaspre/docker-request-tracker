#!/bin/bash

set -euo pipefail

: "${RT_WEB_PORT:=80}"

sed -i "s/RT_WEB_PORT/$RT_WEB_PORT/" /opt/rt4/etc/RT_SiteConfig.pm
sed -i "s/RT_WEB_URL/$RT_WEB_URL/" /opt/rt4/etc/RT_SiteConfig.pm

cd /opt
cp rt4/* rt4_data/
rm -rf rt4
ln -s /opt/rt4_data rt4

exec "$@"
