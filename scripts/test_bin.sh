echo "nyaastrap nyaa-repo-bin tester"
echo "------------------------------"
if [ "$1" = "-o" ]; then 
    echo "INFO: outputting non-built packages to $2"
    rm -rf "$2"
    touch "$2"
    logfile="$(realpath $2)"
fi
cd ../nyaa-repo || exit 1
for i in *
do
    if [ -d "$i" ]
    then
        . "$i/run"
        pkgpath="$(realpath ../packages)"
        pkgname="$pkgpath/nyaa-tarball-$i-$VERSION.tar.gz"
        if [ ! -f "$pkgname" ]
        then
            echo "ERROR: $i is NOT built"
            if [ "$1" = "-o" ]
            then
                echo "$(basename $pkgname)" >> "$logfile"
            fi
        else
            if [ "$1" = "-i" ] || [ "$3" = "-i" ]; then
                echo "INFO: $i is built"
            fi
        fi
    fi
done
