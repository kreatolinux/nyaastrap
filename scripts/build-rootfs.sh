#!/bin/sh
cd /nyaa || exit 1
apt-get update
apt-get upgrade -y
for pkgs in $(cat pkgs)
do
    PKGLIST="$PKGLIST $pkgs"
done
apt-get install $PKGLIST -y
if [ ! -f "nyaa" ]; then
    git clone https://github.com/kreatolinux/nyaa
fi
cp -f nyaa /usr/bin
chmod +x /usr/bin/nyaa
[ -d "nyaa" ] && rm -r nyaa
git config --global --add safe.directory /etc/nyaa
./nyaastrap -c
