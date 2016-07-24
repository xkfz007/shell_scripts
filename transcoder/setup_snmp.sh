#!/bin/bash
ret=$(route|grep '172.16.9.64.*10.200.13.1.*255.255.255.192')
if [ "$ret" == "" ];then
   echo "route will be added"
   route add -net 172.16.9.64 netmask 255.255.255.192 gw 10.200.13.1 bond0
fi
ret=$(ps aux|grep snmpd|grep -v 'grep')
if [ "$ret" == "" ];then
    echo "snmpd will be installed"
    apt-get install snmpd
fi
if [ ! -f /usr/bin/snmpget ];then
    echo "snmp will be installed"
    apt-get install snmp
fi
conf=/etc/snmp/snmpd.conf
if [ ! -f "$conf" ]
then
    echo "$conf does not exist, please check"
fi
if [ ! -f "$conf".bak ];then
    echo "we will backup $conf"
    cp -v $conf ${conf}.bak
fi
ret=$(grep 'udp:0.0.0.0:161' $conf)

if [ "$ret" == "" ];then
    echo "will replace 'udp:127.0.0.1:161' with 'udp:0.0.0.0:161'"
    sed -i 's/udp:127.0.0.1:161/udp:0.0.0.0:161/g' $conf
fi
ret=$(grep 'view.*all.*included.*.1' $conf)
if [ "$ret" == "" ];then
    echo "will insert view   all  included   .1"
    sed -i '/view.*systemonly.*included.*.1.3.6.1.2.1.25.1/a\view   all  included   .1' $conf
fi
ret=$(grep 'rocommunity.*3qi6lun!.* default.*\-V.*all' $conf)
if [ "$ret" == "" ];then
    echo "will replace 'public' with 3qi6lun!"
    sed -i 's/rocommunity.*public.*default.*-V.*systemonly/rocommunity 3qi6lun!  default    -V all/g' $conf
    #sed -i '52s/^.*$/"rocommunity 3qi6lun\!  default    \-V all"/' $conf
fi

service snmpd restart

snmpget -v 1 -c 3qi6lun! 127.0.0.1 1.3.6.1.2.1.1.5.0
snmpget -v 1 -c 3qi6lun! 127.0.0.1 1.3.6.1.4.1.2021.11.50.0



