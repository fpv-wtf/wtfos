# About
**wtfos** is a community framework for modifying the firmware of DJI FPV Goggles and Air Units enabled by [margerine](https://github.com/fpv-wtf/margerine). 

It includes anti-bricking measures, a [configurator](https://github.com/fpv-wtf/wtfos-configurator), a [package manager](https://git.yoctoproject.org/opkg/), a [service manager](https://github.com/davmac314/dinit) and a [vendor service modification framework](https://github.com/fpv-wtf/wtfos-modloader).

You can support the project on [Open Collective](https://opencollective.com/fpv-wtf/donate?amount=10) and join us on our [Discord](https://discord.gg/3rpnBBJKtU).

## Video Guide
See Mad's Tech's [getting started guide](https://www.youtube.com/watch?v=hNOA0kUjKhY).

[![Mad's Tech wtfos getting started guide](https://img.youtube.com/vi/hNOA0kUjKhY/0.jpg)](https://www.youtube.com/watch?v=hNOA0kUjKhY)

## Compatability

### Goggles V2

wtfos-configurator only supports rooting on the **V01.00.0606** firmware. This firmware version must be displayed in the **DJI FPV** mode, **DJI Digital FPV system** a.k.a. DIY mode menus can lie about the actual installed firmware version.

If on any other version or in doubt please use [butter](https://github.com/fpv-wtf/butter#usage) to downgrade first.

### All other Devices
wtfos-configurator supports rooting on **V01.00.0606** or **V01.00.0608** firmware. It is compatible with:

 - DJI Air Unit
 - DJI Air Unit Lite a.k.a. Caddx Vista a.k.a. Runcam Link
 - DJI FPV Goggles V1

### Newer Devices
If using V2 Goggles with O3 Air Units please see [https://fpv.wtf/package/fpv-wtf/o3-multipage-osd](https://github.com/xNuclearSquirrel/o3-multipage-osd).

There are currently no plans to support the O3 Air Unit, Goggles 2, Goggles Integra or Goggles 3.

# Setup and usage

Use the [configurator](https://fpv.wtf/) to [root](https://fpv.wtf/root) your device, [install](https://fpv.wtf/wtfos/install) wtfos and [manage](https://fpv.wtf/root) [community provided packages](https://repo.fpv.wtf/pigeon/).


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
Use [dinit](https://github.com/fpv-wtf/dji-hd-fpv-dinit) which is available in the repository for advanced service management with dependencies, enabling/disabling of units and more. 

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

For a guide on the basics of wtfos packaging see [D3VL's blog post](https://d3vl.com/blog/developing-wtfos-packages/). For native development use the Android [NDK](https://developer.android.com/ndk/downloads) to build binaries with a target of **android-23** and platform of **armeabi-v7a**. 

Check out the [wtfos wiki](https://github.com/fpv-wtf/wtfos/wiki) and the following repos:

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
