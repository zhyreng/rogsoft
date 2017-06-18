#! /bin/sh
eval `dbus export koolproxy`

# stop first
dbus set koolproxy_enable=0
[ -f /jffs/koolshare/koolproxy/koolproxy.sh ] && sh /jffs/koolshare/koolproxy/koolproxy.sh stop
[ -f /jffs/koolshare/koolproxy/kp_config.sh ] && sh /jffs/koolshare/koolproxy/kp_config.sh stop
# remove old files
rm -rf /jffs/koolshare/bin/koolproxy >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/koolproxy.sh >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/nat_load.sh >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/data/*.dat >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/data/*.txt >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/data/*.conf >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/data/gen_ca.sh >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/data/openssl.cnf >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/data/version >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/data/serial >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/rule_store >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/data/rules/1.dat >/dev/null 2>&1

# copy new files
cd /tmp
mkdir -p /jffs/koolshare/koolproxy
mkdir -p /jffs/koolshare/koolproxy/data
cp -rf /tmp/koolproxy/scripts/* /jffs/koolshare/scripts/
cp -rf /tmp/koolproxy/webs/* /jffs/koolshare/webs/
cp -rf /tmp/koolproxy/res/* /jffs/koolshare/res/
if [ ! -f /jffs/koolshare/koolproxy/data/rules/user.txt ];then
	cp -rf /tmp/koolproxy/koolproxy /jffs/koolshare/
else
	mv /jffs/koolshare/koolproxy/data/rules/user.txt /tmp/user.txt.tmp
	cp -rf /tmp/koolproxy/koolproxy /jffs/koolshare/
	mv /tmp/user.txt.tmp /jffs/koolshare/koolproxy/data/rules/user.txt
fi

cp -f /tmp/koolproxy/uninstall.sh /jffs/koolshare/scripts/uninstall_koolproxy.sh


cd /

chmod 755 /jffs/koolshare/koolproxy/koolproxy
chmod 755 /jffs/koolshare/koolproxy/*
chmod 755 /jffs/koolshare/koolproxy/data/*
chmod 755 /jffs/koolshare/scripts/*
[ ! -L "/jffs/koolshare/bin/koolproxy" ] && ln -sf /jffs/koolshare/koolproxy/koolproxy /jffs/koolshare/bin/koolproxy

rm -rf /tmp/koolproxy* >/dev/null 2>&1

[ -z "$koolproxy_mode" ] && dbus set koolproxy_mode=1
[ -z "$koolproxy_acl_default" ] && dbus set koolproxy_acl_default=1

dbus set softcenter_module_koolproxy_install=1
dbus set softcenter_module_koolproxy_version=1.0
dbus set koolproxy_version=1.0

