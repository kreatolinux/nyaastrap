#!/bin/sh
echo "nyaastrap - compile packages mode"
git config --global --add safe.directory /etc/nyaa
cd /etc/nyaa
. /etc/profile
rm -rf /etc/nyaa.installed
ln -s $(which gcc) /bin/cc
ln -s $(which gcc) /bin/c99
sh build-everything.sh
