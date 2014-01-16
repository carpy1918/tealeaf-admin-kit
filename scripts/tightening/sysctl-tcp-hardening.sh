#!/bin/bash

#
#update kernel tcp network params - temp
#

#Don't reply to broadcasts. prevents joining a smurf attack
sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
#Enable protection for bad icmp error messages
sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1
#Enable syncookies for SYN flood attack protection
sysctl -w net.ipv4.tcp_syncookies=1
#Log spoofed, source routed, and redirect packets
sysctl -w net.ipv4.conf.all.log_martians=1
sysctl -w net.ipv4.conf.default.log_martians=1
#Don't allow source routed packets
sysctl -w net.ipv4.conf.all.accept_source_route=0
sysctl -w net.ipv4.conf.default.accept_source_route=0
#Turn on reverse path filtering
sysctl -w net.ipv4.conf.all.rp_filter=1
sysctl -w net.ipv4.conf.default.rp-filter=1
#Don't allow outsiders to alter the routing tables
sysctl -w net.ipv4.conf.all.accept_redirects=0
sysctl -w net.ipv4.conf.default.accept_redirects=0
sysctl -w net.ipv4.conf.all.secure_redirects=0
sysctl -w net.ipv4.conf.default.secure_redirects=0
#Don't act as a router
sysctl -w net.ipv4.ip_forward=0
sysctl -w net.ipv4.conf.all.send_redirects=0
sysctl -w net.ipv4.conf.default.send_redirects=0
