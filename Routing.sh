iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.176.0.0/16
echo nameserver 192.168.122.1 > /etc/resolv.conf
# Strix

route add -net 192.176.7.0 netmask 255.255.255.128 gw 192.176.7.146 #FROGER
route add -net 192.176.0.0 netmask 255.255.252.0 gw 192.176.7.146 #DESMOND
route add -net 192.176.7.128 netmask 255.255.255.248 gw 192.176.7.146 #WISE & EDEM
route add -net 192.176.4.0 netmask 255.255.254.0 gw 192.176.7.150 #BLACBELL
route add -net 192.176.6.0 netmask 255.255.255.0 gw 192.176.7.150 #BRIAR
route add -net 192.176.7.136 netmask 255.255.255.248 gw 192.176.7.150 #SSS & GARDEN

# Ostania
route add -net 0.0.0.0 netmask 0.0.0.0 gw 192.176.7.149


#WestAlis
route add -net 0.0.0.0 netmask 0.0.0.0 gw 192.176.7.145