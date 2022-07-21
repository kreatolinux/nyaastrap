#!/bin/sh
# nyaastrap tests
# test the built rootfs
# Copyright 2021 <kreato@kreatea.space>
#
# This file is part of nyaastrap.
#
# nyaastrap is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# nyaastrap is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with nyaastrap.  If not, see <https://www.gnu.org/licenses/>.
err() {
    echo "E: $1"
    exit 1
}

help() {
    echo "tests.sh [-c] [CONFIG]"
}

info() {
    echo "I: $1"
}

chkroot() {
    [ "$(id -u)" != "0" ] && err "You need to be root to do this action."
}

c() {
    chroot ${CONFIG_BUILDDIR:?} "$@"
}

case $1 in
    "-c")
        chkroot
        if [ -f "$PWD/.config" ]; then
            . "$PWD/.config"
        else
            [ ! -f "$2" ] && err "please enter a config filename"
            [ -f "$2" ] && . "$2"
        fi
        if [ "$CONFIG_TLS_OPENSSL" = "y" ]; then
            info "openssl detected"
        fi
        if [ "$CONFIG_CC_GCC" = "y" ]; then
            info "gcc detected, trying to compile"
            printf '#include <stdio.h>
int main() {
    printf("This is a test message.");
}\n' > ${CONFIG_BUILDDIR:?}/test.c
            c /bin/sh -c "cd / && gcc test.c -o test && ./test" || err "gcc sanity check failed"
        fi
        info "checking bash"
        c /bin/bash "touch test && rm test" || err "bash sanity check failed"
        info "checking git"
        c /bin/sh "git clone https://git.kreatea.space/kreato-linux/nyaastrap --depth=1 && rm -rf nyaastrap/" || err "git sanity check failed"
        info "checking gawk"
        c /bin/sh "echo 'this is a test' | gawk '{ print $1 }'" || err "gawk sanity check failed"
        ;;
    *)
        help
    ;;
esac
        
