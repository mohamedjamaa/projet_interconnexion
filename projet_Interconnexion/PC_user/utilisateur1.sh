#!/bin/bash
ip link set dev eth0 up

dhclient eth0

ip route add default via 192.168.1.2

while true; do sleep 1000;
done
