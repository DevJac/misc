1. Create a file in `/etc/modprobe.d` and place `blacklist i2c_hid` in the file.
2. Enter a line like `GRUB_CMDLINE_LINUX_DEFAULT="psmouse.resetafter=0 quiet splash"` in your grub config at `/etc/default/grub`.

If we do not blacklist i2c_hid then there will be two touchpads listed in `xinput`, which leads to syndaemon problems. If we blacklist i2c_hid, then the system periodically tries to reconnect to the touchpad and the mouse will freeze during this time, but the `psmouse.resetafter=0` kernal option will fix this.
