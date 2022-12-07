# Jarkom-Modul-5-D09-2022

## Anggota Kelompok D09
| No | Nama | NRP |
| ------ | ------ | ----- |
| 1 | Monica Narda Davita | 5025201009 |
| 2 | Alya Shofarizqi Inayah | 5025201113 |
| 3 | Meisya Salsabila Indrijo Putri | 5025201114 |

## Prefix IP
192.189.X.X

## VLSM GNS3
### Topologi GNS3
![topologiVLSM]()

Dari pengelompokan subnet tersebut didapatkan subnet terbesar memiliki /21 bit, sehingga pohon pembagian IP dapat dibuat menjadi sebagai berikut:

### Pohon IP VLSM
![pohonIPVLSM]()

Setelah didapatkan IP pada setiap subnet paling bawah, maka dicari netmask dan broadcast pada setiap subnet tersebut. Hasilnya sebagai berikut:

### Tabel Netmask dan Broadcast ID
![NetmaskBroadcastVLSM]()

### VLSM Routing - Setting Network Configuration
![NetworkConfigurationVLSM]()

**Konfigurasi: The Strix**
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
      address 192.189.7.146
      netmask 255.255.255.252

auto eth2
iface eth2 inet static
      address 192.189.7.149
      netmask 255.255.255.252
```

**Westalis**
```
auto eth0
iface eth0 inet static
      address 192.189.7.145
      netmask 255.255.255.252
      gateway 192.189.7.146

auto eth1
iface eth1 inet static
      address 192.189.7.129
      netmask 255.255.255.248

auto eth2
iface eth2 inet static
      address 192.189.7.1
      netmask 255.255.255.128

auto eth3
iface eth3 inet static
      address 192.189.0.1
      netmask 255.255.252.0
```

**Ostania**
```
auto eth0
iface eth0 inet static
      address 192.189.7.150
      netmask 255.255.255.252
      gateway 192.189.7.149

auto eth1
iface eth1 inet static
      address 192.189.6.1
      netmask 255.255.255.0

auto eth2
iface eth2 inet static
      address 192.189.4.1
      netmask 255.255.254.0

auto eth3
iface eth3 inet static
      address 192.189.7.137
      netmask 255.255.255.248
```

**DNS SERVER: Eden**
```
auto eth0
iface eth0 inet static
      address 192.189.7.130
      netmask 255.255.255.248
      gateway 192.189.7.129
```

**DHCP SERVER: Wise**
```
auto eth0
iface eth0 inet static
      address 192.189.7.131
      netmask 255.255.255.248
      gateway 192.189.7.129
```

**Web Server 1: SSS**
```
auto eth0
iface eth0 inet static
      address 192.189.7.139
      netmask 255.255.255.248
      gateway 192.189.7.137
```

**Web Server 2: Garden**
```
auto eth0
iface eth0 inet static
      address 192.189.7.138
      netmask 255.255.255.248
      gateway 192.189.7.137
```

### VLSM Routing - Setting Host Configuration
![ClientServerVLSM]()

Karena permintaan soal adalah client mendapatkan alamat IP dinamis dari DHCP Server,
maka konfigurasi pada tiap client (Forger, Desmond, Briar, Blackbell) adalah sama

**Konfigurasi Client: Forger, Desmond, Briar, Blackbell**
```
auto eth0
iface eth0 inet dhcp
```

### VLSM Routing - Routing
**STRIX**
```
route add -net 192.189.7.128 netmask 255.255.255.248 gw 192.189.7.145
route add -net 192.189.7.128 netmask 255.2.255.128 gw 192.189.7.145
route add -net 192.189.0.0 netmask 255.255.252.0 gw 192.189.7.145
route add -net 192.189.6.0 netmask 255.255.255.0 gw 192.189.7.150 
route add -net 192.189.4.0 netmask 255.255.254.0 gw 192.189.7.150
route add -net 192.189.7.136 netmask 255.255.255.248 gw 192.189.7.150
```

**WESTALIS**
```
route add -net 192.189.7.148 netmask 255.255.255.252 gw 192.189.7.146   #A5 
route add -net 192.189.6.0 netmask 255.255.255.0 gw 192.189.7.146       #A6 
route add -net 192.189.4.0 netmask 255.255.254.0 gw 192.189.7.146       #A7 
route add -net 192.189.7.136 netmask 255.255.255.248 gw 192.189.7.146   #A8 
route add -net 0.0.0.0 netmask 0.0.0.0 gw 192.189.7.146                 #default
```

**OSTANIA**
```
route add -net 192.189.7.128 netmask 255.255.255.248 gw 192.189.7.149   #A1 
route add -net 192.189.7.0 netmask 255.255.255.128 gw 192.189.7.149     #A2 
route add -net 192.189.0.0 netmask 255.255.252.0 gw 192.189.7.149       #A3 
route add -net 192.189.7.144 netmask 255.255.255.252 gw 192.189.7.149   #A4 
route add -net 0.0.0.0 netmask 0.0.0.0 gw 192.189.7.149                 #default
```

### VLSM Routing - IP Tables The Resonance
Pada router Strix jalankan perintah berikut ini (belum menjawab soal 1):
```
  iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.189.0.0/21
```

### VLSM Routing - Setting resolv.conf
Pada semua node selain Strix (termasuk router-router lain), jalankan perintah berikut ini:
```
  echo nameserver 192.168.122.1 > /etc/resolv.conf
```

### Konfigurasi DNS Server pada Node Eden
Terletak pada script DNSServer.sh pada node eden. Script ini sudah berada di .bashrc sehingga tidak perlu dibash lagi
```
echo ' zone "eden.D09.com" {
        type master;
        file "/etc/bind/eden/eden.D09.com";
}; ' > /etc/bind/named.conf.local

mkdir /etc/bind/eden

cp /etc/bind/db.local /etc/bind/eden/eden.D09.com

echo -e '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     eden.D09.com. root.eden.D09.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      eden.D09.com.
@       IN      A       192.189.7.130   ; IP Eden
@       IN      AAAA    ::1
' > /etc/bind/eden/eden.D09.com

service bind9 restart
```

### Konfigurasi DHCP Server pada Node Wise
Terletak pada script DHCPServer.sh pada node Wise. Script ini sudah berada di .bashrc sehingga tidak perlu dibash lagi
**Konfigurasi pada isc-dhcp-server**
```
echo -e '
INTERFACES="eth0"
' > /etc/default/isc-dhcp-server
```

**Konfigurasi pada dhcpd.conf untuk IP Dinamis**
```
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
```

### Konfigurasi Web Server pada Node SSS
Terletak pada script WebServerSSS.sh pada node SSS. Script ini sudah berada di .bashrc sehingga tidak perlu dibash lagi
```
echo '
<?php
        phpinfo();
?>
' > /var/www/html/index.php
```

### Konfigurasi Web Server pada Node Garden
Terletak pada script WebServerGarden.sh pada node Garden. Script ini sudah berada di .bashrc sehingga tidak perlu dibash lagi
```
echo '
<?php
        phpinfo();
?>
' > /var/www/html/index.php
```

### Konfigurasi DHCP Relay pada Node Ostania
Terletak pada script DHCPRelayOstania.sh pada node Ostania. Script ini belum berada di .bashrc sehingga perlu dibash lagi.
```
echo -e '
# Defaults for isc-dhcp-relay initscript
# sourced by /etc/init.d/isc-dhcp-relay
# installed at /etc/default/isc-dhcp-relay by the maintainer scripts

#
# This is a POSIX shell fragment
#

# What servers should the DHCP relay forward requests to?
SERVERS="192.189.7.131"

# On what interfaces should the DHCP relay (dhrelay) serve DHCP requests?
INTERFACES="eth0 eth1 eth2 eth3"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=""
' > /etc/default/isc-dhcp-relay
```
Setelah bash, maka DHCP Relay perlu direstart, lakukan command berikut pada node Ostania
```
service isc-dhcp-relay restart
```
### Konfigurasi DHCP Relay pada Node Westalis
Terletak pada script DHCPRelayWestalis.sh pada node Westalis. Script ini belum berada di .bashrc sehingga perlu dibash lagi.
```
echo -e '
# Defaults for isc-dhcp-relay initscript
# sourced by /etc/init.d/isc-dhcp-relay
# installed at /etc/default/isc-dhcp-relay by the maintainer scripts

#
# This is a POSIX shell fragment
#

# What servers should the DHCP relay forward requests to?
SERVERS="192.189.7.131"

# On what interfaces should the DHCP relay (dhrelay) serve DHCP requests?
INTERFACES="eth0 eth1 eth2 eth3"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=""
' > /etc/default/isc-dhcp-relay
```
Setelah bash, maka DHCP Relay perlu direstart, lakukan command berikut pada node Ostania
```
service isc-dhcp-relay restart
```

Setelah itu, restart tiap node client (Forger, Desmond, Briar, dan Blackbell) dan coba untuk ping google.com maupun antar node
```
ping google.com -c 3
```
Untuk melihat IP client bisa menggunakan:
```
ifconfig eth0
```
### Bukti Client Berhasil Mengakses Web Garden
![BuktiWebServerSuccess]()
* Guideau to Phanora

### Bukti Berhasil Ping Antar Node
![BuktiPingSuccess]()
* dari Forger menuju Blackbell. Diketahui bahwa IP Forger saat itu adalah 192.189.7.4 dan IP Blackbell adalah 192.189.4.3

### Bukti Berhasil Ping Google Melalui IP Dinamis
![BuktiPingGoogleSuccess]()
* Forger melakukan ping google.com sebanyak lima kali

### File GNS3
File konfigurasi dan routing GNS3 ada pada: [Click Here]()
