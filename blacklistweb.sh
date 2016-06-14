#!/bin/bash
### BEGIN INIT INFO
# Provides:          blacklistweb.com
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start daemon at boot time
# Description:       blacklistweb for Squid
# by:	             maravento.com, novatoz.com, gateproxy.com
### END INIT INFO

clone https://github.com/maravento/blacklistweb
a=$(md5sum blacklistweb/blacklistweb.txt | awk '{print $1}')
b=$(cat blacklistweb/blacklistweb.md5 | awk '{print $1}')

if [ "$a" = "$b" ]
then 
	echo " la suma coincide"
	cp blacklistweb/blacklistweb.txt /etc/acl/blacklistweb.txt
  	rm -rf blacklistweb
	date=`date +%d/%m/%Y" "%H:%M:%S`
	echo "<--| Blacklistweb for Squid: ejecucion $date |-->" >> /var/log/syslog.log
	echo " OK"
else
	echo " la suma no coincide"
	echo " Verifique su conexion de internet y reinicie el script"
	rm -rf blacklistweb
	date=`date +%d/%m/%Y" "%H:%M:%S`
	echo "<--| Blacklistweb for Squid: abortada $date |-->" >> /var/log/syslog.log
	exit
fi
