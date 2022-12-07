iptables -A FORWARD -p tcp -d 192.189.7.131 -i eth0 -j DROP # Drop semua TCP
iptables -A FORWARD -p udp -d 192.189.7.131 -i eth0 -j DROP # Drop semua UDP