#!/bin/bash

function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

#########################################################################################
echo "Enter the IP address of this server :"
read srvip

while ! valid_ip $srvip 
do
   echo "Bad IP Address"
echo "Please Re-Enter the IP address of this server :"
read srvip
done



if valid_ip $srvip
then
sed -i "s/10.20.30.215/$srvip/g"  "/etc/asterisk/http.conf"
sed -i "s/10.20.30.215/$srvip/g" "/etc/asterisk/sip.conf"

else echo "Bad IP Address"
fi
########################################################################################
echo "Enter the STUN IP Address :"
read stunIP

while ! valid_ip $stunIP
do
   echo "Bad STUN IP Address"
echo "Please Re-Enter the STUN IP address :"
read stunIP
done

if valid_ip $stunIP
then
sed -i "s+;stunServerAddress=<IpAddress>+stunServerAddress=$stunIP+g" "/etc/kurento/modules/kurento/WebRtcEndpoint.conf.ini"
else echo "Bad STUN IP Address"
fi

echo "Enter the STUN Port number :"
read stunprt
sed -i "s+;stunServerPort=<Port>+stunServerPort=$stunprt+g" "/etc/kurento/modules/kurento/WebRtcEndpoint.conf.ini"

##############################################################################################
echo "Enter the CUCM IP Address :"
read cucmIP

while ! valid_ip $cucmIP
Hamza Abusalah
do
   echo "Bad STUN IP Address"
echo "Please Re-Enter the CUCM IP address :"
read cucmIP
done

if valid_ip $cucmIP
then
sed -i "s+host=172.16.14.10+host=$cucmIP+g" "/etc/asterisk/sip.conf"
else echo "Bad CUCM IP Address"
fi

##############################################################################################

echo "Enter the CUCM Port :"
read cucmprt
sed -i "s+port=5060+port=$cucmprt+g" "/etc/asterisk/sip.conf"

echo "Enter the full path for crt file :"
read crt
sed -i "s+/etc/ssl/certs/netsync.com.crt+$crt+g"  "/etc/asterisk/http.conf" 
sed -i "s+/etc/ssl/certs/netsync.com.crt+$crt+g" "/etc/asterisk/sip.conf"
echo "Enter the full path for key file :"
read crt1
sed -i "s+/etc/ssl/private/netsync.com.key+$crt1+g" "/etc/asterisk/sip.conf"
sed -i "s+/etc/ssl/private/netsync.com.key+$crt1+g"  "/etc/asterisk/http.conf" 


