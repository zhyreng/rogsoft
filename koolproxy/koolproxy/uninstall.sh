#! /bin/sh

sh /jffs/koolshare/koolproxy/kp_config.sh stop
rm -rf /jffs/koolshare/bin/koolproxy >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/koolproxy >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/kp_config.sh >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/koolproxy.sh >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/nat_load.sh >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/rule_store >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/data/1.dat >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/data/koolproxy.txt >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/data/user.txt >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/data/rules >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/data/koolproxy_ipset.conf >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/data/gen_ca.sh >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/data/openssl.cnf >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/data/serial >/dev/null 2>&1
rm -rf /jffs/koolshare/koolproxy/data/version >/dev/null 2>&1

