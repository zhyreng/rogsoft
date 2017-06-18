#!/bin/sh

softcenter_install() {
	if [ -d "/tmp/softcenter" ]; then
		# coping files
		mkdir -p /koolshare/bin/
		mkdir -p /koolshare/init.d/
		mkdir -p /koolshare/scripts/
		mkdir -p /koolshare/configs/
		mkdir -p /koolshare/webs/
		mkdir -p /koolshare/res/

		# dectect if menu mounted
		mount=`mount | grep "menuTree"`
		[ -n "$mount" ] && umount /www/require/modules/menuTree.js
		sleep 1
		mv -rf /tmp/softcenter/webs/menuTree.js /koolshare/webs/
		mount --bind /jffs/koolshare/webs/menuTree.js /www/require/modules/menuTree.js

		cp -rf /tmp/softcenter/webs/* /koolshare/webs/
		cp -rf /tmp/softcenter/webs/menuTree.js /koolshare/webs/.menuTree.js
		cp -rf /tmp/softcenter/res/* /koolshare/res/
		cp -rf /tmp/softcenter/init.d/* /koolshare/init.d/
		cp -rf /tmp/softcenter/bin/* /koolshare/bin/
		cp -rf /tmp/softcenter/perp /koolshare/
		cp -rf /tmp/softcenter/scripts /koolshare/
		chmod 755 /koolshare/bin/*
		chmod 755 /koolshare/init.d/*
		chmod 755 /koolshare/perp/*
		chmod 755 /koolshare/perp/.boot/*
		chmod 755 /koolshare/perp/.control/*
		chmod 755 /koolshare/perp/httpdb/*
		chmod 755 /koolshare/perp/skipd/*
		chmod 755 /koolshare/scripts/*
		
		# dectect if menu mounted
		mount=`mount | grep "menuTree"`
		[ -n "$mount" ] && umount /www/require/modules/menuTree.js
		cp -rf /tmp/softcenter/webs/menuTree.js /koolshare/webs/menuTree.js
		mount --bind /jffs/koolshare/webs/menuTree.js /www/require/modules/menuTree.js

		# remove something
		rm -rf /tmp/softcenter

		# make shadowsocks note upgrade
		if [ -f "/koolshare/ss/ssconfig.sh" ]; then
			dbus set softcenter_module_shadowsocks_install=4
		fi

		# make softcenter auto start when mounting
		[ ! -L "/jffs/.asusrouter" ] && ln -sf /jffs/.asusrouter /jffs/koolshare/bin/kscore.sh

		# PATH environment of softcenter for ssh users
		mkdir -p /jffs/etc
		[ ! -L "/jffs/etc/profile" ] && ln -sf /jffs/etc/profile /jffs/koolshare/scripts/base.sh

		# creat nat-start and nat-start when not exist
		mkdir -p /jffs/scripts
		if [ ! -f "/jffs/scripts/wan-start" ];then
			cat > /jffs/scripts/wan-start <<-EOF
			#!/bin/sh
			sh /jffs/koolshare/bin/ks-wan-start.sh
			EOF
			chmod +x /jffs/scripts/wan-start
		fi
		if [ ! -f "/jffs/scripts/nat-start" ];then
			cat > /jffs/scripts/nat-start <<-EOF
			#!/bin/sh
			sh /jffs/koolshare/bin/ks-nat-start.sh
			EOF
			chmod +x /jffs/scripts/nat-start
		fi
		


		# others thing
		mkdir -p /tmp/upload
		mkdir -p /jffs/configs/dnsmasq.d

		# now try to reboot software center
		PERP=`perpls | grep -E "httpdb|skipd|\+\+" | wc -l`
		[ "$PERP" -ne "2" ] && sh /jffs/koolshare/bin/kscore.sh || echo software center runing normally!
		
	fi
}

softcenter_install
