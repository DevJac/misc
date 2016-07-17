1. Create a file named `blacklist-i2c_hid.conf` (the name can be different, but this follows the existing convention) in `/etc/modprobe.d` and place `blacklist i2c_hid` in the file.
2. Run the command: `sudo depmod -ae && update-initramfs -u`
3. Enter a line like `GRUB_CMDLINE_LINUX_DEFAULT="psmouse.resetafter=0 quiet splash"` in your grub config at `/etc/default/grub`. The `psmouse.resetafter=0` is the important part.
4. Run the command: `sudo update-grub`

If we do not blacklist the i2c_hid module then there will be two touchpads listed in `xinput` (try running the `xinput` command), which leads to syndaemon problems. If we blacklist i2c_hid, then the system periodically tries to reconnect to the touchpad and the mouse will freeze during this time, but the `psmouse.resetafter=0` kernel option will fix this.

5. Consider removing `quiet` and `splash` from `GRUB_CMDLINE_LINUX_DEFAULT`. This will show a terminal during boot and shutdown instead of a useless splash screen.
