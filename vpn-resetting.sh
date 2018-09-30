#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

# バックアップファイル名
BACKUP="configure.`date +%Y%m%d`"

# config path
CFGPATH='vpn l2tp remote-access outside-address'

# 現在のIP
NOW=`curl -s ipinfo.io/ip`
# 設定されてるIP
OUTSIDE=`cli-shell-api showCfg ${CFGPATH} | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`

#echo -e "now ipaddress is \t ${NOW}
#old ipadress is \t ${OLD}
#outside address \t ${OUTSIDE}"

#echo "set outside address."

if [ ${OUTSIDE} != ${NOW} ]; then
    configure
    save ${BACKUP}
    set ${CFGPATH} ${NOW}
    commit
    save
fi

exit
