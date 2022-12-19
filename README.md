# About
**wtfos** is a community framework for modifying the firmware of DJI FPV Goggles and Air Units enabled by [margerine](https://github.com/fpv-wtf/margerine). 

It includes anti-bricking measures, a [configurator](https://github.com/fpv-wtf/wtfos-configurator), a [package manager](https://git.yoctoproject.org/opkg/), a [service manager](https://github.com/davmac314/dinit) and a [vendor service modification framework](https://github.com/fpv-wtf/wtfos-modloader).

You can support the project on [Open Collective](https://opencollective.com/fpv-wtf/donate?amount=10) and join us on our [Discord](https://discord.gg/3rpnBBJKtU).

## Video Guide
See Mad's Tech's [getting started guide](https://www.youtube.com/watch?v=hNOA0kUjKhY).

[![Mad's Tech wtfos getting started guide](https://img.youtube.com/vi/hNOA0kUjKhY/0.jpg)](https://www.youtube.com/watch?v=hNOA0kUjKhY)

## Compatability
wtfos-configurator officially only supports rooting on **V01.00.0606** firmware. It is compatible with:

 - DJI Air Unit
 - DJI Air Unit Lite a.k.a. Caddx Vista a.k.a. Runcam Link
 - DJI FPV Goggles V1
 - DJI FPV Goggles V2

#### V2 Goggles
On V2 Goggles you must flash **V01.00.0606** from DIY mode a.k.a. DJI HD FPV System mode using assistant in order to be able to root. If you have anything other than V01.00.0606 shown when checked in DJI FPV Drone mode, the root will not work. Both modes must have V01.00.0606.

Following that, if you own and use the DJI FPV Drone, you may wish to use the free [Dronehacks](https://drone-hacks.com/download) firmware flasher to upgrade to V01.02.0001 obtained from [Dank Drone Downloader](http://dankdronedownloader.com/DDD2/app/index.php?model=gl170&ver=01.02.0001&type=Other&Brand=DJI) for best compatibility prior to installing wtfos. If you upgrade at a later time, simply re-install wtfos.

# Setup and usage

Use the [configurator](https://fpv.wtf/) to root your device, install wtfos and manage [community provided packages](https://repo.fpv.wtf/pigeon/).

Some of the available packages include:

 - [msp-osd](https://github.com/bri3d/msp-osd) for full OSD
 - [enable_live_audio](https://github.com/funneld/djifpv_enable_live_audio/) to enable live audio playback from an Air Unit
 - [auto-record](http://repo.fpv.wtf/pigeon/auto-record_1.0.0_pigeon-glasses.ipk) to start recording automatically as soon as an air unit is connected
 - [tweak-prevent-force-upgrade](https://repo.fpv.wtf/pigeon/tweak-prevent-force-upgrade_0.9.0_armv7-3.2.ipk) resets any forced upgrade statues (caused by connecting to the Fly app in FPV Drone mode) on startup

See the configurator for a full and up to date listing.

# Built In Features

### Brick prevention
To offer some degree of protection against messing things up, **wtfos-system** makes a copy of your system partition and mounts it over the real one early during startup. 

You can skip this and other wtfos loading procedures by holding down the bind button on your device during bootups and waiting to hear **3 short beeps** from the buzzer for confirmation.

Then your device should be booted with any modifications skipped at startup to the original system partition and you should once again have access to the device via ADB. 

### OPKG package management
The opkg package manager is available with [fpv-wtf/opkg-repo](https://repo.fpv.wtf/pigeon/) added as a source. 

Everything is installed in `/opt/` (which is a symlink to `/blackbox/wtfos/opt/`) which is added your your path automatically by the scripts in `/blackbox/wtfos/mkshrc.d/`.

The easiest way to browse and manage packages is via the the [configurator](https://fpv.wtf/).

#### Advanced usage

For command line usage instructions see the [opkg wiki page](https://openwrt.org/docs/guide-user/additional-software/opkg) for using the `opkg` command in the cli.

### Service management
Use [dinit](https://github.com/stylesuxx/dji-hd-fpv-dinit) which is available in the repository for advanced service management with dependencies, enabling/disabling of units and more. 

Users can manage services with the [configurator](https://fpv.wtf/) or the `dinitctl ` command in the cli.

Packages wishing to use dinit should depend on it and install their unit in /opt/etc/dinit.d/.

## Uninstalling
Should you wish to return to the plain adb root hack, use the configurator to uninstall wtfos.

To also remove adb access and restore compatibility with the Assistant on all the V1 gear run the following in the shell:

    wtfos-remove-adb
    reboot

V2 Goggles do not require removal of adb to work with Assistant.

## I need help

Hop on our [Discord](https://discord.gg/3rpnBBJKtU).

## Developers

Use the Android [NDK](https://developer.android.com/ndk/downloads) to build binaries with a target of **android-23** and platform of **armeabi-v7a**. Check out the [wtfos wiki](https://github.com/fpv-wtf/wtfos/wiki) and the following repos:

 - https://github.com/stylesuxx/ipk-example
 - https://github.com/fpv-wtf/opkg-repo
 - https://github.com/bri3d/msp-osd
 - https://github.com/fpv-wtf/dfbdoom
 - https://github.com/fpv-wtf/wtfos-modloader
 - https://github.com/funneld/djifpv_enable_live_audio

## Support the effort

If you'd like, you can support the project on [Open Collective](https://opencollective.com/fpv-wtf/donate?amount=10), send some ETH to `0xbAB1fec80922328F27De6E2F1CDBC2F322397637` or BTC to `3L7dE5EHtyd2b1tXBwdnWC2MADkV2VTbrq`.

## Credits
Based on the [margerine](https://github.com/fpv-wtf/margerine) root method. Please blame:
 - [j005u](https://github.com/j005u) for wtfos-system and wtfos-modloader
 - [stylesuxx](https://github.com/stylesuxx) for wtfos-configurator
 - [bri3d](https://github.com/bri3d) for msp-osd
 - [funnel](https://github.com/funneld) for a bunch of the tweaks
