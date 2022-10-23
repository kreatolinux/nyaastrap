#!/bin/sh
echo "nyaastrap - compile packages mode"
git config --global --add safe.directory /etc/nyaa
cd /etc/nyaa
. /etc/profile
sh build-everything.sh
