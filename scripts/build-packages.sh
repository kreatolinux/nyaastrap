#!/bin/sh
echo "nyaastrap - compile packages mode"
git config --global --add safe.directory /etc/nyaa
cd /etc/nyaa
. /etc/profile
rm -rf /etc/nyaa.installed
sh build-everything.sh
