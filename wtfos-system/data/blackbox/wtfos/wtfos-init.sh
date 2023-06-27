#!/system/bin/sh
alias logme="tee /dev/kmsg | tee -a /blackbox/wtfos.log"

remount_slash=false

echo "wtfos: entware starting"
if mount | grep -q "rootfs ro"; then 
    remount_slash=true
    /system/xbin/busybox mount -o rw,remount / 2>&1 | logme
fi
sleep 1
mkdir -p /bin
ln -sf /system/bin/sh /bin/sh

#set up /opt
if [[ ! -L /opt ]] ; then
    ln -sf /blackbox/wtfos/opt /opt
fi
#make sure our /opt/tmp is a link to /tmp
if [ ! -L /opt/tmp ]; then
    rm -rf /opt/tmp || true
    ln -s /tmp /opt/tmp
fi

#remount / ro if necessesary 
if [ "$remount_slash" = true ] ; then
    /system/xbin/busybox mount -o ro,remount /
fi

sleep 1
echo "wtfos: /opt and /bin/sh created"

/system/xbin/busybox mount -t ext4 -o loop,rw /blackbox/wtfos/system.img /system | logme
echo "wtfos: system loopmounted" | logme

/system/bin/${WTFOS_TARGET_SCRIPT} || true
echo "wtfos: ran dji startup script" | logme

#i don't think this should be blocking (forever)
#but otherwise we have a bad time for some reason with dinit installed?
#the dinit start script spawns with & 
#needs investigation
. /opt/etc/init.d/rc.unslung start 2>&1 >> /blackbox/wtfos.log &
echo "wtfos: started entware unslung" | logme

exit 0