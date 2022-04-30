#!/bin/bash
set -x
for dir in *; do
    if [ -f "$dir/make-package.sh" ]; then
        cd $dir
        ./make-package.sh
        cd ..
    fi
done