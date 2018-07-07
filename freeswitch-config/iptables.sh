#!/bin/sh

CIP=$(docker inspect --format='{{.NetworkSettings.IPAddress}}' freeswitch)
iptables -A DOCKER -t nat -p udp -m udp ! -i docker0 --dport 10000:20000 -j DNAT --to-destination $CIP:10000-20000
iptables -A DOCKER -p udp -m udp -d $CIP/32 ! -i docker0 -o docker0 --dport 10000:20000 -j ACCEPT
iptables -A POSTROUTING -t nat -p udp -m udp -s $CIP/32 -d $CIP/32 --dport 10000:20000 -j MASQUERADE

