#!/bin/sh

ifc=$(ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active' | grep -E -o -m 1 '^[^\t:]+')
wg=$(wg show | grep "latest handshake" |  tr -cd '[:digit:]')
tun=$(ifconfig | grep "tun0" )
call=$(wget -q --spider https://google.com; echo $?)

if [ -n "$wg" ]
then
  if [ "${wg}" -ge 0 ]
  then
    vpn="active"
  fi
elif [ -n "$tun" ]
then
  vpn="active"
else
  vpn="inactive"
fi

if [ "${ifc}" = "wlan0" ]
then
  interface=""
elif [ "${ifc}" = "eth0" ]
then
  interface=""
elif [ "${ifc}" = "ue0" ]
then
  interface=""
elif [ "${ifc}" = "re0" ]
then
  interface=""
elif [ "${ifc}" = "em0" ]
then
  interface=""
else
  interface=""
fi

if [ $((call)) -eq 0 ]
then
  status="online"
  if [ vpn="active" ]
  then
    status="vpn"
  fi
else
  status="offline"
fi

echo '{"text": "'$interface'", "alt": "'$vpn'", "tooltip": "", "class": "'$status'", "percentage": "" }'

exit 0
