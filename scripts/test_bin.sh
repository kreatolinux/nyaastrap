#!/bin/sh
# nyaastrap bin tester
if [ "$1" = "-o" ]; then 
    echo "INFO: outputting non-built packages to $2"
    export HAS_LOGS=y
    rm -rf "$2"
    touch "$2"
    logfile=$(realpath "$2")
fi

cd ../nyaa-repo || exit 1

chkignored() {
    for i in $(echo "$IGNORE_PACKAGES" | tr "," "\n")
    do
        [ "$i" = "$1" ] && echo "$1" 
    done
}

err() {
    if [ -z "$(chkignored $1)" ]
    then
        echo "ERROR: $1 is NOT built"
        if [ "$HAS_LOGS" = "y" ]
        then
            echo "$(basename "$2")" >> "$logfile"
        fi
    fi
}

info() {
    echo "INFO: $?"
}

for i in *
do
    if [ -d "$i" ]
    then
        # shellcheck source=/dev/null
        . "$i/run"
        pkgpath="$(realpath ../packages)"
        pkgname="$pkgpath/nyaa-tarball-$i-$VERSION.tar.gz"
        if [ ! -f "$pkgname" ]
        then
            err "$i" "$pkgname"
        else
            if [ "$1" = "-i" ] || [ "$3" = "-i" ]; then
                info "$i is built"
            fi
        fi
    fi
done
