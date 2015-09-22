#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo
    echo ' Usage:'
    echo '      docker run -d --name="tinyproxy" [-e "LOG_LEVEL=<LogLevel>"] [-e "CONNECT_PORT=all"] -p <HostPort>:8888 tinyproxy <ACL>'
    echo
    echo '          - Set <LogLevel>. Can be set with "Info" (default value), "Connect", "Notice", "Warning", "Error" or "Critical"'
    echo '          - Set <HostPort> to the port you wish the proxy to be accessible from.'
    echo '          - Set <ACL> to "ANY" to allow unrestricted proxy access, or one or more space seperated IP/CIDR addresses for tighter security.'
    echo
    echo '      Examples:'
    echo '          docker run -d --name="tinyproxy" -p 1111:8888 tinyproxy ANY'
    echo '          docker run -d --name="tinyproxy" -p 2222:8888 tinyproxy 123.45.67.89'
    echo '          docker run -d --name="tinyproxy" -p 3333:8888 tinyproxy 123.45.67.89 192.168.0.0/16'
    echo '          docker run -d --name="tinyproxy" -p 4444:8888 -e "LOG_LEVEL=Notice" tinyproxy 123.45.67.89'
    echo '          docker run -d --name="tinyproxy" -p 5555:8888 -e "LOG_LEVEL=Warning" tinyproxy 123.45.67.89 192.168.0.0/16'
    echo '          docker run -d --name="tinyproxy" -p 6666:8888 -e "CONNECT_PORT=all" tinyproxy 123.45.67.89 192.168.0.0/16'
    echo

    exit 1
fi

# Allow
for allow in $@; do
    echo "Allow ${allow}" >> /etc/tinyproxy.conf
done

# LogLevel
if [ -n "${LOG_LEVEL}" ]; then
    sed -i "s/LogLevel Info/LogLevel ${LOG_LEVEL}/" /etc/tinyproxy.conf
fi

if [ -n "${CONNECT_PORT}" ]; then
    if [ "all" == "${CONNECT_PORT}" ]; then
        sed -i "s/ConnectPort/#ConnectPort/" /etc/tinyproxy.conf
    fi
fi

tinyproxy -c /etc/tinyproxy.conf
tail -f /var/log/tinyproxy/tinyproxy.log
