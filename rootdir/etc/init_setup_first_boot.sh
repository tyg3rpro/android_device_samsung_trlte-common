#!/system/bin/sh
if [ -f /home/phablet/.first-setup-done ]; then
    exit
fi
#fix egl permission for unity8:
chmod 666 /dev/kgsl-3d0
#add udev rules:
cat /var/lib/lxc/android/rootfs/ueventd*.rc|grep ^/dev|sed -e 's/^\/dev\///'|awk '{printf "ACTION==\"add\", KERNEL==\"%s\", OWNER=\"%s\", GROUP=\"%s\", MODE=\"%s\"\n",$1,$3,$4,$2}' | sed -e 's/\r//' > /etc/udev/rules.d/70-trltetmo.rules
#fix dbus errors:
chmod 4777 /usr/lib/dbus-1.0/dbus-daemon-launch-helper
chown root:messagebus /usr/lib/dbus-1.0/dbus-daemon-launch-helper
chmod u+s /usr/lib/dbus-1.0/dbus-daemon-launch-helper
#add _apt user for apt:
adduser --force-badname --system --home /nonexistent --no-create-home --quiet _apt
#fix incorrect name 
mkdir -p /etc/system-image/config.d
touch /home/phablet/.first-setup-done
exit
