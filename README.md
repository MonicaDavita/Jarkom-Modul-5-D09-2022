# Jarkom-Modul-5-D09-2022

## Anggota Kelompok D09
| No | Nama | NRP |
| ------ | ------ | ----- |
| 1 | Monica Narda Davita | 5025201009 |
| 2 | Alya Shofarizqi Inayah | 5025201113 |
| 3 | Meisya Salsabila Indrijo Putri | 5025201114 |

## Prefix IP
192.189.X.X

## KONFIGURAS VLSM GNS3 (SOAL A-D)
### Topologi GNS3
![topologiVLSM](https://github.com/MonicaDavita/Jarkom-Modul-5-D09-2022/blob/main/aset/konfigurasi/clusteringVLSM.png?raw=true)

Dari pengelompokan subnet tersebut didapatkan subnet terbesar memiliki /21 bit, sehingga pohon pembagian IP dapat dibuat menjadi sebagai berikut:

### Pohon IP VLSM
![pohonIPVLSM](https://github.com/MonicaDavita/Jarkom-Modul-5-D09-2022/blob/main/aset/konfigurasi/pohonIPVLSM.png?raw=true)

Setelah didapatkan IP pada setiap subnet paling bawah, maka dicari netmask dan broadcast pada setiap subnet tersebut. Hasilnya sebagai berikut:

### Tabel Netmask dan Broadcast ID
![NetmaskBroadcastVLSM](https://github.com/MonicaDavita/Jarkom-Modul-5-D09-2022/blob/main/aset/konfigurasi/netBroadcastID.jpeg?raw=true)

### VLSM Routing - Setting Network Configuration
![NetworkConfigurationVLSM](https://github.com/MonicaDavita/Jarkom-Modul-5-D09-2022/blob/main/aset/konfigurasi/routerConf.jpeg?raw=true)

**Strix**
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
![ClientServerVLSM](https://github.com/MonicaDavita/Jarkom-Modul-5-D09-2022/blob/main/aset/konfigurasi/clientServer.jpeg?raw=true)

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
Setelah bash, maka DHCP Relay perlu direstart, lakukan command berikut pada node Westalis
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
![BuktiWebServerSuccess](https://github.com/MonicaDavita/Jarkom-Modul-5-D09-2022/blob/main/aset/konfigurasi/BlackbellAksesGarden.jpeg?raw=true)
* Blackbell berhasil membuka laman pada Web Server Garden (IP Garden: 192.189.7.138)

### Bukti Berhasil Ping Antar Node
![BuktiPingSuccess](https://github.com/MonicaDavita/Jarkom-Modul-5-D09-2022/blob/main/aset/konfigurasi/ForgerPingBlackbell.png?raw=true)
* Ping dari Forger menuju Blackbell. Diketahui bahwa IP Forger saat itu adalah 192.189.7.4 dan IP Blackbell adalah 192.189.4.3

### Bukti Berhasil Ping Google Melalui IP Dinamis
![BuktiPingGoogleSuccess](https://github.com/MonicaDavita/Jarkom-Modul-5-D09-2022/blob/main/aset/konfigurasi/ForgerPingGoogle.jpeg?raw=true)
* Forger melakukan ping google.com sebanyak lima kali yang menandakan setting DHCP sudah berhasil

### File GNS3
* File konfigurasi dan routing GNS3 ada pada: [Click Here](https://github.com/MonicaDavita/Jarkom-Modul-5-D09-2022/blob/main/Modul-5-D09.gns3project)
* Pastikan untuk mengikuti langkah-langkahnya melalui link berikut: [Click Me](https://github.com/MonicaDavita/Jarkom-Modul-5-D09-2022/blob/main/Panduan%20Menjalankan%20GNS3.txt)

## Nomor 1
### Soal
Agar topologi yang kalian buat dapat mengakses keluar, kalian diminta untuk mengkonfigurasi Strix menggunakan iptables, tetapi Loid tidak ingin menggunakan MASQUERADE
### Jawaban
Ada pada script no1.sh di node Strix, jalankan script.
Source 192.168.122.2 merupakan IP alternatif
```
iptables -t nat -A POSTROUTING -s 192.189.0.0/21 -o eth0 -j SNAT --to-source 192.168.122.2
```

## Nomor 2
### Soal
Kalian diminta untuk melakukan drop semua TCP dan UDP dari luar Topologi kalian pada server yang merupakan DHCP Server demi menjaga keamanan.
### Jawaban
Ada pada script no2.sh di node Strix, jalankan script.
IP 192.189.7.131 merupakan alamat IP dari Wise (DHCP Server)
```
iptables -A FORWARD -p tcp -d 192.189.7.131 -i eth0 -j DROP # Drop semua TCP
iptables -A FORWARD -p udp -d 192.189.7.131 -i eth0 -j DROP # Drop semua UDP
```
### Bukti Berhasil
Jika berhasil, maka instalasi pada node Wise tidak dapat berjalan karena transaksi TCP dan UDP diblokir (dihapus)
![BuktiBerhasilSoal2](https://github.com/MonicaDavita/Jarkom-Modul-5-D09-2022/blob/main/aset/Soal%202/no2WiseStuck.jpeg?raw=true)
* Terlihat bahwa instalasi pada node Wise tidak berhasil setelah no2.sh dibash pada node Strix 

## Nomor 3
### Soal
Kalian diminta untuk membatasi DHCP dan DNS Server hanya boleh menerima maksimal 2 koneksi ICMP secara bersamaan menggunakan iptables, selebihnya didrop.
### Jawaban
Jalankan script no3.sh pada DHCP Server WISE dan DNS Server Eden.
```
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p icmp -m connlimit --connlimit-above 2 --connlimit-mask 0 -j DROP
```
![no3 sh](https://user-images.githubusercontent.com/96837287/206891867-5c91775c-8f97-45ab-8910-a08115f5ed15.jpg)

### Bukti Berhasil
Melakukan testing menuju Eden (192.189.7.130) dan menuju Wise (192.189.7.131) dengan melakukan ping pada Blackbell(Client 1), Briar(Client 2), dan Desmond(Client 3)

Blackbell menuju Eden
![Blackbell 130](https://user-images.githubusercontent.com/96837287/206892017-83f133a1-7dd5-4661-9e94-2da98d1d75e4.jpg)

Briar menuju Eden
![Briar 130](https://user-images.githubusercontent.com/96837287/206892020-75bc71ae-3006-43ac-bbea-3fa11d613a6f.jpg)

Desmond menuju Eden
![Desmond 130](https://user-images.githubusercontent.com/96837287/206892021-565cbaf6-7b0d-4030-b666-f2b5ec36f533.jpg)


Blackbell menuju Wise
![Blackbell 131](https://user-images.githubusercontent.com/96837287/206892037-de71a07f-d3f5-4ef4-bc7d-3e5d9f75a49f.jpg)

Briar menuju Wise
![Briar 130 131](https://user-images.githubusercontent.com/96837287/206892038-f74e8076-8c58-4007-97b5-a220b47300ac.jpg)

Desmond menuju Wise
![Desmond 131](https://user-images.githubusercontent.com/96837287/206892044-6511eb39-7354-4270-8d5d-35f79e7a191e.jpg)

## Nomor 4
### Soal
Akses menuju Web Server hanya diperbolehkan disaat jam kerja yaitu Senin sampai Jumat pada pukul 07.00 - 16.00.
### Jawaban
Menjalankan script no4.sh pada Garden dan SSS untuk mengatur waktu Reject, dengan command
```
iptables -A INPUT -m time --timestart 07:00 --timestop 16:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
iptables -A INPUT -j REJECT
```
### Bukti Berhasil
Testing dengan ping IP Web Server Garden (192.189.7.138) dan SSS (192.189.7.139) pada Client. Berhubung hari ini merupakan hari Minggu, 11 Dec 2022 yang mana bukan merupakan weekdays maka bukti yang dapat kami lampirkan merupakan testing ping sebelum dan sesudah menjalankan script no4.sh

Briar menuju Garden (Sebelum di bash)
![Briar 138 reach](https://user-images.githubusercontent.com/96837287/206899456-49db6870-0ccf-4546-8efc-59729f5450ed.jpg)

Briar menuju SSS (Sebelum di bash)
![Briar 139 reach](https://user-images.githubusercontent.com/96837287/206899458-a40a15ab-d0a3-460c-91c0-cb315cfccf91.jpg)

Setelah di bash no4.sh
![Briar 139 Unreachable](https://user-images.githubusercontent.com/96837287/206899460-c6ea537c-361e-4704-9d7c-74fa8abe5021.jpg)

## Nomor 5
### Soal
Karena kita memiliki 2 Web Server, Loid ingin Ostania diatur sehingga setiap request dari client yang mengakses Garden dengan port 80 akan didistribusikan secara bergantian pada SSS dan Garden secara berurutan dan request dari client yang mengakses SSS dengan port 443 akan didistribusikan secara bergantian pada Garden dan SSS secara berurutan.
### Jawaban
Konfigurasi untuk masing-masing node dengan port untuk request masing-masing node adalah 80 dan 443 dengan menggunakan `--dport` karena saat terjadi request akan terdistribusi antara SSS & Garden. Selain itu, akan dibatasi secara bergantian dengan menggunakan `--every 2` sehingga akan bergantian terdistribusinya dengan mengarahkan ke node lain dengan menggunakan `--to-destination`.

Ostania
```
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 192.189.7.138 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 192.189.7.138:80
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 192.189.7.138 -j DNAT --to-destination 192.189.7.139:80
iptables -A PREROUTING -t nat -p tcp --dport 443 -d 192.189.7.139 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 192.189.7.139:443
iptables -A PREROUTING -t nat -p tcp --dport 443 -d 192.189.7.139 -j DNAT --to-destination 192.189.7.138:443
```
### Bukti Berhasil
<img width="960" alt="no5" src="https://user-images.githubusercontent.com/94627623/206899368-f4070d3d-b7b7-4c2d-a15e-84214b7af3fe.png">


## Nomor 6
### Soal
Karena Loid ingin tau paket apa saja yang di-drop, maka di setiap node server dan router ditambahkan logging paket yang di-drop dengan standard syslog level.
### Jawaban
Restart terlebih dahulu DHCP pada `WISE`
```
service isc-dhcp-server restart
service isc-dhcp-server restart
```
Lalu isikan syntax `sylog` pada `WISE` untuk melihat paket yang di drop
```
iptables -N LOGGING
iptables -A INPUT -p icmp -m connlimit --connlimit-above 2 --connlimit-mask 0 -j LOGGING
iptables -A LOGGING -j LOG --log-prefix "IPTables-Dropped: "
iptables -A LOGGING -j DROP
```
Kemudian isikan `sylog` pada semua node
```
iptables -A INPUT -m time --timestart 07:00 --timestop 16:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT

iptables -N LOGGING
iptables -A INPUT -j LOGGING
iptables -A LOGGING -j LOG --log-prefix "IPTables-Rejected: "
iptables -A LOGGING -j REJECT
```
### Bukti Berhasil
<img width="960" alt="no6_2" src="https://user-images.githubusercontent.com/94627623/206899516-3eea8cb2-9247-4438-a326-9c978aa7dfd4.png">
<img width="960" alt="no6_3" src="https://user-images.githubusercontent.com/94627623/206899560-6aedf60f-d4c5-4992-b103-811319fd9bc4.png">
