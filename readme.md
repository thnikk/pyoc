# PyOC
This script was made to simplify overclocking using amdgpu's hwmon interface. It's nice that the hwmon interface is so simple, but it's not something you can realistically use without scripting, so this script is meant to fill the gap. It will find the hwmon path for a given vendor and product ID and set the overclocking profile provided in `/etc/pyoc.json`, which is just the vid:pid and a set of commands to set the overclock, which are all outlined [here](https://dri.freedesktop.org/docs/drm/gpu/amdgpu.html#pp-od-clk-voltage).

# Installation
1) Run `sudo make install` to install the script to `/usr/local/bin`

2) Run the command with `sudo pyoc` to generate the config.

3) Edit the config at `/etc/pyoc.json` (it's set up for a 6800 and 5700 XT with conservative overclocking and undervolting).

4) Apply the overclock by running `sudo pyoc VENDOR:PRODUCT`, where VENDOR and PRODUCT are the vendor and product IDs for your card.

#### Optional for persistent overclock
If you don't want to manually run the OC script every time, you can use a udev rule to automatically apply the overclock when the card is bound to the amdgpu driver. Be aware that this is dangerous and can prevent your system from booting, and you may need to chroot in to delete the file. I only recommend doing this after you've verified that the overclock runs fine.

5) Replace `VENDOR`, and `PRODUCT` to match your card in `99-overclock-amdgpu.rules` and copy it to `/etc/udev/rules.d/`. You can do this easily using sed with `su -c "sed 's/VENDOR/1002/g;s/PRODUCT/73bf/g' 99-overclock-amdgpu.rules > /etc/udev/rules.d/99-overclock-amdgpu.rules"` (for an RX 6800). If you want to overclock multiple cards, you can use multiple lines in your rules file.

6) Reload your udev rules with `sudo udevadm control --reload-rules && sudo udevadm trigger`
