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