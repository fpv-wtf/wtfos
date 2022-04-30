# Status
**Very Alpha**. This repo has currently only been tested, somewhat, on a gl170.

# Setup

\#Todo
Use margerines built in install command:

    node margerine.js install wtfos
You're done.

### But I want to do it myself
Fine.
Have margerine proxy started by running the following in your (1.1-wip branch) **margerine directory**.

    node margerine.js proxy

In another terminal (or by appending & to the previous command in your favorite Unix shell) run the following **in this directory**:

    adb push setup /tmp/
    adb shell sh /tmp/setup/bootsrap-wtfos.sh
Enjoy.


# Features

### Brick prevention
To offer some degree of protection against messing things up, **wtfos-system** makes a copy of your system partition and mounts it over the real one early during startup. You can skip this and other wtf-os loading procedures by holding down the bind button on your device during bootups and waiting to hear 3 short beeps from the buzzer for confirmation.
Then your device should be booted with any modifications skipped at startup to the original system partition and you should once again have access to the device via ADB. 

### OPKG package management
The opkg package manager is available with [fpv-wtf/opkg-repo](https://repo.fpv.wtf/pigeon/) and [Entware](https://bin.entware.net/armv7sf-k3.2/Packages.html) added as sources. 
Everything is installed in **/opt/** (which is a symlink to /blackbox/wtfos/opt/) which is added your your path automatically by the scripts in /blackbox/wtfos/mkshrc.d/.

Example:

    export http_proxy="http://127.0.0.1:8089/"
    opkg install msp-osd

For the time being you need to `export http_proxy="http://127.0.0.1:8089/"` and have the margerine proxy running for http to https translation so that busybox wget doesn't get confused.

You may wish to `echo "export http_proxy=\"http://127.0.0.1:8089/\"" > /blackbox/wtfos/mkshrc.d/20-margerineproxy.sh` to do this automatically for you. 

You'll find that proper busybox symlinks to things such as vi have been made in /opt/bin/. Note that these paths were appended to the end of the PATH variable, rather than beginning, because Entware busybox does not behave well with all commands.

You may provide your own means of connectivity and SSL capable wget in order to circumvent this requirement.

### Service management
Use standard style init.d scripts in /opt/etc/init.d/ for basic boot time scripts and standard entware packages.
Use [dinit](https://github.com/stylesuxx/dji-hd-fpv-dinit) which is available in the repository for advanced service management with dependencies, enabling/disabling of units and more. Packages wishing to use dinit should depend on it and install their configuration file in /opt/etc/dinit.d/.