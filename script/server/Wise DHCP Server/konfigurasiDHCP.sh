echo -e 'subnet 192.189.7.0 netmask 255.255.255.128{
    range 192.189.7.2 192.189.7.126;
    option routers 192.189.7.1;
    option broadcast-address 192.189.7.127;
    option domain-name-servers 192.189.7.130;
}
subnet 192.189.0.0 netmask 255.255.252.0{
    range 192.189.0.2 192.189.3.254;
    option routers 192.189.0.1;
    option broadcast-address 192.189.3.255;
    option domain-name-servers 192.189.7.130;
}
subnet 192.189.7.128 netmask 255.255.255.248{
        option routers 192.189.7.129;
}
subnet 192.189.6.0 netmask 255.255.255.0{
        range 192.189.6.2 192.189.6.254;
        option routers 192.189.6.1;
        option broadcast-address 192.189.6.255;
        option broadcast-address 192.189.6.255;
        option domain-name-servers 192.189.7.130;
}
subnet 192.189.4.0 netmask 255.255.254.0{
        range 192.189.4.2 192.189.5.254;
        option routers 192.189.4.1;
        option broadcast-address 192.189.5.255;
        option domain-name-servers 192.189.7.130;
}
' > /etc/dhcp/dhcpd.conf
service isc-dhcp-server start