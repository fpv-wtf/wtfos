#wtfos

{ # try
    alias logme="tee /dev/kmsg | tee -a /blackbox/wtfos.log"
    beep () {
      if [[ $WTFOS_DEVICE == gl* ]]; then
        for i in `seq 1 $1`; do
          test_pwm 0 2349 70 1 1
          sleep 0.3
          test_pwm 0 2300 50 1 0
          sleep 0.1
        done
      fi
      ##todo else flash LED
    }

    echo "wtfos: starting wtfos" | logme
    #mount blackbox early
    mount_dev=/dev/block/platform/soc/f0000000.ahb/f0400000.dwmmc0/by-name/blackbox
    e2fsck -fy $mount_dev 
    busybox mount -t ext4 $mount_dev /blackbox 2>&1 | logme
    echo "wtfos: mounted blackbox" | logme
    
    if [ -f /blackbox/wtfos/device/$(getprop ro.product.device).env ]; then

      export $(grep -v '^#' /blackbox/wtfos/device/$(getprop ro.product.device).env | xargs)
      #for some reason on lt150(/*150?) devmem takes a few tries sometimes
      #this will occiasionally result in boots where unslung gets permission denied
      #why? cpu caching of some sort?
      tries=0
      until [ $(getenforce) = "Permissive" ] || [ $tries -eq 25 ]
      do
          busybox devmem ${WTFOS_SELINUX_DISABLE} 32 0
          tries=$((tries+1))
      done

      echo "wtfos: disabled selinux" | logme

      #make sure our cmdline bindmount file hasn't been deleted or isn't blank (bad time)
      if [[ ! -f /blackbox/wtfos/cmdline ]] || [[ ! -s /blackbox/wtfos/cmdline ]]
      then
        mkdir -p /blackbox/wtfos/
        cat /proc/cmdline | busybox sed -e 's/state=production/state=engineering/g' -e 's/verity=1/verity=0/g' -e 's/debug=0/debug=1/g' > /blackbox/wtfos/cmdline
      fi
      #doesn't work (nor matter) on gl170
      /system/xbin/busybox mount -o bind,ro /blackbox/wtfos/cmdline /proc/cmdline || true

      #so we can get events
      insmod /system/lib/modules/gpio_keys.ko | logme

      if getevent -i -l | grep -q "KEY_PROG3\\*"; 
      then
        echo "wtfos: bind button down, skipping the rest of startup" | logme
        beep 3
      else
        if sh /blackbox/wtfos/wtfos-init.sh startup; then
          echo "wtfos: startup suceeded"
          exit 0
        else
          umount /blackbox
          echo "wtfos: startup failed, resuming normal startup" | logme
            beep 5
        fi
      fi
    else
      umount /blackbox
      echo "wtfos: device config not found, /blackbox/wtfos/ missing or corrupt?" | logme
      beep 4
    fi

} || { # catch
    echo "wtfos: wtfos startup failed, see kmesg" | logme
    #default scripts won't like it being mounted
    umount /blackbox
}

#MUST have empty row at the end
#/wtfos
