#wtfos
#these are leftovers to ensure you still have adb access
tries=0
until [ $(getenforce) = "Permissive" ] || [ $tries -eq 25 ]
do
    busybox devmem ${WTFOS_SELINUX_DISABLE} 32 0
    tries=$((tries+1))
done

#we don't have blackbox yet so re-create the cmdline into tmp each startup
cat /proc/cmdline | busybox sed -e 's/state=production/state=engineering/g' -e 's/verity=1/verity=0/g' -e 's/debug=0/debug=1/g' > /tmp/cmdline
/system/xbin/busybox mount -o bind,ro /tmp/cmdline /proc/cmdline || true

#MUST have empty row at the end
#/wtfos
