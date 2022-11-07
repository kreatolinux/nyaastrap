#!/bin/sh
cd /nyaa || exit 1
git config --global --add safe.directory /etc/nyaa
./nyaastrap -c
cd /nyaa/out/
tar -czvf /nyaa/kreato-linux-"$(date +%d-%m-%Y)".tar.gz *
