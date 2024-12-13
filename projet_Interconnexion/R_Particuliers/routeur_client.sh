#!/bin/bash
ip link set dev eth1 up
ip link set dev eth2 up

ip addr add 120.0.32.1/22 dev eth1
ip addr add 120.0.40.1/22 dev eth2

ip route add default 120.0.98.2/23

echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -t filter -A OUTPUT -p icmp -j ACCEPT
iptables -t filter -A INPUT -p icmp -j ACCEPT
iptables -t filter -A FORWARD -p icmp -j ACCEPT

iptables -A OUTPUT -p udp --dport 520 -j ACCEPT
iptables -A INPUT -p udp --dport 520 -j ACCEPT
iptables -A FORWARD -p udp --dport 520 -j ACCEPT

while true; do sleep 1000;
done
