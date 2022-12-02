#!/bin/sh
DEFCONFIG=changeme
cd /nyaa || exit 1
git config --global --add safe.directory /etc/nyaa

if [ ! -f "../defconfig/$DEFCONFIG" ]; then
	cd .. || exit 1
	./nyaastrap -c
else
	cd .. || exit 1
	./nyaastrap -c defconfig/$DEFCONFIG
fi

cd /nyaa/out/
tar -czvf /nyaa/kreato-linux-"$(date +%d-%m-%Y)".tar.gz *
