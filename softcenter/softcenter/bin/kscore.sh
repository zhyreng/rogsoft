#!/bin/sh
#set -x

export KSROOT=/jffs/koolshare
source $KSROOT/scripts/base.sh
export PERP_BASE=$KSROOT/perp
mkdir -p /tmp/upload

# ===============================
# start perp
echo start perp skipd and httpdb
sh $KSROOT/perp/perp.sh

# dectect if menu mounted
mount=`mount | grep "menuTree"`
[ -z "$mount" ] && mount --bind /jffs/koolshare/webs/menuTree.js /www/require/modules/menuTree.js
mkdir -p /jffs/etc/dnsmasq.d
