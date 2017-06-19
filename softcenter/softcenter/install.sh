#!/bin/sh

softcenter_install() {
	if [ -d "/tmp/softcenter" ]; then
		# coping files
		mkdir -p /jffs/koolshare/bin/
		mkdir -p /jffs/koolshare/init.d/
		mkdir -p /jffs/koolshare/scripts/
		mkdir -p /jffs/koolshare/configs/
		mkdir -p /jffs/koolshare/webs/
		mkdir -p /jffs/koolshare/res/
		cp -rf /tmp/softcenter/webs/* /jffs/koolshare/webs/
		cp -rf /tmp/softcenter/res/* /jffs/koolshare/res/
		cp -rf /tmp/softcenter/init.d/* /jffs/koolshare/init.d/
		cp -rf /tmp/softcenter/bin/* /jffs/koolshare/bin/
		cp -rf /tmp/softcenter/perp /jffs/koolshare/
		cp -rf /tmp/softcenter/scripts /jffs/koolshare/
		chmod 755 /jffs/koolshare/bin/*
		chmod 755 /jffs/koolshare/init.d/*
		chmod 755 /jffs/koolshare/perp/*
		chmod 755 /jffs/koolshare/perp/.boot/*
		chmod 755 /jffs/koolshare/perp/.control/*
		chmod 755 /jffs/koolshare/perp/httpdb/*
		chmod 755 /jffs/koolshare/perp/skipd/*
		chmod 755 /jffs/koolshare/scripts/*

		# remove something
		rm -rf /tmp/softcenter

		# make shadowsocks note upgrade
		if [ -f "/jffs/koolshare/ss/ssconfig.sh" ]; then
			dbus set softcenter_module_shadowsocks_install=4
		fi

		# make softcenter auto start when mounting
		[ ! -L "/jffs/.asusrouter" ] && ln -sf /jffs/.asusrouter /jffs/koolshare/bin/kscore.sh

		# PATH environment of softcenter for ssh users
		mkdir -p /jffs/etc
		[ ! -L "/jffs/etc/profile" ] && ln -sf /jffs/etc/profile /jffs/koolshare/scripts/base.sh

		# some soft link
		[ ! -L "/jffs/koolshare/scripts/ks_app_remove.sh" ] && ln -sf /jffs/koolshare/scripts/ks_app_install.sh /jffs/koolshare/scripts/ks_app_remove.sh

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
