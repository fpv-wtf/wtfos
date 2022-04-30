#wtfos
set -a
for f in /blackbox/wtfos/mkshrc.d/*.sh; do 
    . $f
done
set +a
#/wtfos
: place customisations above this line
