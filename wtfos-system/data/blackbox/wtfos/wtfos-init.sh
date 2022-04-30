#!/system/bin/sh
alias logme="tee /dev/kmsg | tee -a /blackbox/wtfos.log"

if [ "$1" != "startup" ]; then
   echo "you probably don't want to run me by hand" | logme
   exit 2
fi

echo "wtfos: entware starting"
/system/xbin/busybox mount -o rw,remount / 2>&1 | logme
sleep 1
mkdir -p /bin
ln -sf /system/bin/sh /bin/sh
if [[ ! -L /opt ]] ; then
    ln -sf /blackbox/wtfos/opt /opt
fi
/system/xbin/busybox mount -o ro,remount /
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
/opt/etc/init.d/rc.unslung start 2>&1 | logme &
echo "wtfos: started entware unslung" | logme

exit 0