#!/bin/bash
set -x
for dir in *; do
    if [ -f "$dir/control/control" ]; then
        cd $dir
        NAME=$(cat ./control/control | grep Package | cut -d" " -f2)
        ARCH=$(cat ./control/control | grep Architecture | cut -d" " -f2)
        VERSION=$(cat ./control/control | grep Version | cut -d" " -f2)
        IPK_NAME="${NAME}_${VERSION}_${ARCH}.ipk"

        mkdir -p data

        rm -rf ipk
        rm -rf $IPK_NAME

        mkdir ipk

        echo "2.0" > ipk/debian-binary

        cd control
        tar --owner=0 --group=0 -czvf ../ipk/control.tar.gz .
        cd ..

        cd data
        tar --owner=0 --group=0 -czvf ../ipk/data.tar.gz .
        cd ..

        cd ipk
        tar --owner=0 --group=0 -czvf "../../${IPK_NAME}" ./control.tar.gz ./data.tar.gz ./debian-binary
        cd ..
        cd ..
    fi
done