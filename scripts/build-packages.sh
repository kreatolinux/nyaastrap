#!/bin/sh
echo "nyaastrap - compile packages mode"
git config --global --add safe.directory /etc/nyaa
. /etc/profile
rm -rf /etc/nyaa.installed
cd /nyaa/scripts || exit 1
IGNORE_PACKAGES=$IGNORE_PACKAGES sh test_bin.sh -o test.txt
cd /nyaa/nyaa-repo || exit 1
for i in *
do
    if [ -d "$i" ]; then
        . "$i/run"
        while read line
        do
            [ "nyaa-tarball-$i-$VERSION.tar.gz" = "$line" ] && nyaa b $i -y
            VERSION_NEW=$VERSION
	        . /nyaa/nyaa-repo/$i/run
	        sed -i "s/$VERSION/$VERSION_NEW/g" /nyaa/nyaa-repo/$i/run
        done < /nyaa/scripts/test.txt
    fi
done
rm -f /nyaa/scripts/test.txt
