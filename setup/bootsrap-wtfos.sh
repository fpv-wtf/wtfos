#prep fs for entware

mount -o rw,remount /
mkdir -p /bin
ln -sf /system/bin/sh /bin/sh
if [[ ! -L /opt ]] ; then
    ln -sf /blackbox/wtfos/opt /opt
fi
mount -o ro,remount /
#use proxy provided by margerine
#don't worry, it upgrades http to https
export http_proxy="http://127.0.0.1:8089/"

cd /tmp/setup
mkdir -p /blackbox/wtfos/opt/bin
cp ./busybox /blackbox/wtfos/opt/bin
chmod u+x /blackbox/wtfos/opt/bin/busybox
ln -sf /blackbox/wtfos/opt/bin/busybox /blackbox/wtfos/opt/bin/wget 
export PATH="$PATH:/opt/bin:/opt/sbin"
#install entware
wget -O - http://bin.entware.net/armv7sf-k3.2/installer/alternative.sh | sh -e
#add our repo
sed -i '/#wtfos/,/#\/wtfos/d' /opt/etc/opkg.conf
echo "#wtfos\nsrc/gz fpv-wtf http://repo.fpv.wtf/pigeon\n#/wtfos" >> /opt/etc/opkg.conf
opkg update
#install wtfos meta package (dinit, wtfos-system)
if [ -f wtfos-system*.ipk ]; then
    opkg install "$(set -- wtfos-system*.ipk; echo "$1")"
else 
    opkg install --force-reinstall wtfos wtfos-system
fi
