route add -net 192.189.7.128 netmask 255.255.255.248 gw 192.189.7.149   #A1 
route add -net 192.189.7.0 netmask 255.255.255.128 gw 192.189.7.149     #A2 
route add -net 192.189.0.0 netmask 255.255.252.0 gw 192.189.7.149       #A3 
route add -net 192.189.7.144 netmask 255.255.255.252 gw 192.189.7.149   #A4 
route add -net 0.0.0.0 netmask 0.0.0.0 gw 192.189.7.149                 #default