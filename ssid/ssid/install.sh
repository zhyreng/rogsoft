#! /bin/sh
cd /tmp
cp -rf /tmp/ssid/ssid /jffs/koolshare/
cp -rf /tmp/ssid/scripts/* /jffs/koolshare/scripts/
cp -rf /tmp/ssid/webs/* /jffs/koolshare/webs/
cp -rf /tmp/ssid/res/* /jffs/koolshare/res/
cp -rf /tmp/ssid/init.d/* /jffs/koolshare/init.d/
cd /
rm -rf /tmp/ssid* >/dev/null 2>&1


chmod 755 /jffs/koolshare/ssid/*
chmod 755 /jffs/koolshare/scripts/ssid*
chmod 755 /jffs/koolshare/init.d/ssid*

