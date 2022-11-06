#!/bin/sh
cd /nyaa || exit 1
git config --global --add safe.directory /etc/nyaa
./nyaastrap -c
