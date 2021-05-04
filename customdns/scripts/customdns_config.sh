#!/bin/sh
# load path environment in dbus databse
eval `dbus export customdns`
source /koolshare/scripts/base.sh
CONFIG_FILE=/jffs/configs/dnsmasq.d/custom_dns.conf

start_customdns(){
	ln -s /koolshare/configs/custom_dns.conf $CONFIG_FILE
	service restart_dnsmasq
	# creat start_up file
	# if [ ! -L "/koolshare/init.d/N97customdns.sh" ]; then 
	# 	ln -sf /koolshare/scripts/customdns_config.sh /koolshare/init.d/N97customdns.sh
	# fi

	# creat start_up file
	# if [ ! -L "/koolshare/init.d/S97customdns.sh" ]; then 
	# 	ln -sf /koolshare/scripts/customdns_config.sh /koolshare/init.d/S97customdns.sh
	# fi
}

stop_customdns(){
	rm $CONFIG_FILE
	service restart_dnsmasq
	# rm -rf /koolshare/init.d/N97customdns.sh
	# rm -rf /koolshare/init.d/S97customdns.sh
}

case $ACTION in
start)
	if [ "$customdns_enable" == "1" ]; then
		start_customdns
	else
		logger "[软件中心]: 未设置开机启动，跳过！"
	fi
	;;
stop)
	stop_customdns
	;;
*)
	if [ "$customdns_enable" == "1" ]; then
		stop_customdns
		start_customdns
	else
		stop_customdns
	fi
	;;
esac
