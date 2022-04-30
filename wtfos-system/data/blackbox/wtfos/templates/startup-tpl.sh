#wtfos

{ # try
    alias logme="tee /dev/kmsg | tee -a /blackbox/wtfos.log"
    beep () {
      for i in `seq 1 $1`; do
        test_pwm 0 2349 70 1 1
        sleep 0.3
        test_pwm 0 2300 50 1 0
        sleep 0.1
      done
    }

    echo "wtfos: starting wtfos" | logme
    #mount blackbox early
    mount_dev=/dev/block/platform/soc/f0000000.ahb/f0400000.dwmmc0/by-name/blackbox
    e2fsck -fy $mount_dev 
    mount -t ext4 $mount_dev /blackbox 2>&1 | logme
    echo "wtfos: mounted blackbox" | logme
    
    if [ -f /blackbox/wtfos/device/$(getprop ro.product.device).env ]; then

      export $(grep -v '^#' /blackbox/wtfos/device/$(getprop ro.product.device).env | xargs)
      busybox devmem ${WTFOS_SELINUX_DISABLE} 32 0 | logme
      echo "wtfos: disabled selinux" | logme

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

