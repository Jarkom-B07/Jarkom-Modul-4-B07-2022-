# Laporan Praktikum JARKOM Kelompok B07 #
## Detail Anggota Kelompok ##
| Nama | NRP |
| --- | --- | 
| Danial Farros Maulana |5025201004 |
| Rendi Dwi Francisko| 5025201056 | 
| Ahmad Ibnu Malik Rahman| 5025201232 |

## Topologi ##
File `.gns3project` dapat di akses melalui [link berikut](B07-MODUL5.gns3project) berikut 

## Pendahuluan Praktikum ##

Setelah kalian mempelajari semua modul yang telah diberikan, Loid ingin meminta bantuan untuk terakhir kalinya kepada kalian. Dan kalian dengan senang hati mau membantu Loid.

### Soal (A) ###
Tugas pertama kalian yaitu membuat topologi jaringan sesuai dengan rancangan yang diberikan Loid dibawah berikut :

![Gambar 1](/src/topologi_awal.png)

**ket :** Eden adalah DNS Server; WISE adalah DHCP Server; Garden dan SSS adalah Web Server; Jumlah Host pada Forger adalah 62 host; Jumlah Host pada Desmond adalah 700 host; Jumlah Host pada Blackbell adalah 255 host; Jumlah Host pada Briar adalah 200 host

**Pembahasan :**
berikut adalah hasil topologi yang dibuat
![Gambar 2](/src/topologi_hasil.png)

### Soal (b) ###
Untuk menjaga perdamaian dunia, Loid ingin meminta kalian untuk membuat topologi tersebut menggunakan teknik CIDR atau VLSM setelah melakukan subnetting.

**Pembahasan :**
- **Tahap 1** Penentuan Subnet
  ![Gambar 3](/src/subneting.png)
  pada gambar di atas dapat terlihat terdapat 8 subnet di dalam topologi. Dengan menggunakan teknik classful setiap subnet akan memiliki netmask **/21** karena semua subnet memiliki jumlah host di bawah **2048**. Sehingga pembagian IP yang memungkinkan untuk topologi di atas adalah sebagai berikut.
- **Tahap 2** Pembagian Topologi

| Subnet Name | NeededSize | AlocatedSize | Address | Mask | Dec Mask | Assignable Range (Start) | Assignable Range (End) | Broadcast |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| A2 | 701 | 1022 | 192.176.0.0 | /22 | 255.255.252.0 | 192.176.0.1 | 192.176.3.254 | 192.176.3.255 |
| A6 | 256 | 510 | 192.176.4.0 | /23 | 255.255.254.0 | 192.176.4.1 | 192.176.5.254 | 192.176.5.255 |
| A7 | 201 | 254 | 192.176.6.0 | /24 | 255.255.255.0 | 192.176.6.1 | 192.176.6.254 | 192.176.7.127 |
| A3 | 63 | 126 | 192.176.7.0 | /25 | 255.255.255.128 | 192.176.7.1 | 192.176.7.126 | 192.176.7.127 |
| A1 | 3 | 6 | 192.176.7.128 | /29 | 255.255.255.248 | 192.176.7.129 | 192.176.7.134 | 192.176.7.135 |
| A8 | 3 | 6 | 192.176.7.136 | /29 | 255.255.255.248 | 192.176.7.137 | 192.176.7.142 | 192.176.7.143 |
| A4 | 2 | 2 | 192.176.7.144 | /30 | 255.255.255.252 | 192.176.7.145 | 192.176.7.146 | 192.176.7.147 |
| A5 | 2 | 2 | 192.176.7.148 | /30 | 255.255.255.252 | 192.176.7.149 | 192.176.7.150 | 192.176.7.151 |

- **Tahap 3** Subneting
![Gambar 4](/src/diagram_vlsm.png)

### Soal (C) ###
Anya, putri pertama Loid, juga berpesan kepada anda agar melakukan Routing agar setiap perangkat pada jaringan tersebut dapat terhubung.

**Pembahasan :**
Proses konfigurasi dilakukan pada setiap node dengan konfigurasi sebagai berikut :
- Strix 
    ```
    auto lo
    iface lo inet loopback

    auto eth0
    iface eth0 inet dhcp
    hwaddress ether b6:23:6b:b5:5d:33

    auto eth1
    iface eth1 inet static
    address 192.176.7.149
    netmask 255.255.255.252

    auto eth2
    iface eth2 inet static
    address 192.176.7.145
    netmask 255.255.255.252
    ```
- Westalis
    ```
    auto lo
    iface lo inet loopback

    auto eth0
    iface eth0 inet static
    address 192.176.7.146
    netmask 255.255.255.252
    gateway 192.176.7.145

    auto eth1
    iface eth1 inet static
    address 192.176.0.1
    netmask 255.255.252.0

    auto eth2
    iface eth2 inet static
    address 192.176.7.1
    netmask 255.255.255.128

    auto eth3
    iface eth3 inet static
    address 192.176.7.129
    netmask 255.255.255.248
    ```
- Ostania
    ```
    auto lo
    iface lo inet loopback

    auto eth0
    iface eth0 inet static
    address 192.176.7.150
    netmask 255.255.255.252
    gateway 192.176.7.149

    auto eth1
    iface eth1 inet static
    address 192.176.4.1
    netmask 255.255.254.0

    auto eth2
    iface eth2 inet static
    address 192.176.7.137
    netmask 255.255.255.248

    auto eth3
    iface eth3 inet static
    address 192.176.6.1
    netmask 255.255.255.0
    ```
- **Client** : Forer, Desmond, Blackbell, Briar
    ```
    auto lo
    iface lo inet loopback

    auto eth0
    iface eth0 inet dhcp
    ```
- Eden : 
    ``` 
    auto eth0
    iface eth0 inet static
    address 192.176.7.130
    netmask 255.255.255.248
    gateway 192.176.7.129
    ```
- Wise :
    ```
    auto eth0
    iface eth0 inet static
    address 192.176.7.131
    netmask 255.255.255.248
    gateway 192.176.7.129
    ```
- Garden :
    ```
    auto eth0
    iface eth0 inet static
    address 192.176.7.138
    netmask 255.255.255.248
    gateway 192.176.7.137
    ```
- SSS
    ```
    auto eth0
    iface eth0 inet static
    address 192.176.7.139
    netmask 255.255.255.248
    gateway 192.176.7.137
    ```
### Soal (D) ###
Tugas berikutnya adalah memberikan ip pada subnet Forger, Desmond, Blackbell, dan Briar secara dinamis menggunakan bantuan DHCP server. Kemudian kalian ingat bahwa kalian harus setting DHCP Relay pada router yang menghubungkannya.

**Pembahasan :**
- Tahap 1 Proses routing pada device router 
    ```sh
    // Strix
    route add -net 192.176.7.128 netmask 255.255.255.248 gw 192.176.7.146 
    route add -net 192.176.7.0 netmask 255.255.255.128 gw 192.176.7.146 
    route add -net 192.176.0.0 netmask 255.255.252.0 gw 192.176.7.146

    route add -net 192.176.4.0 netmask 255.255.254.0 gw 192.176.7.150 
    route add -net 192.176.6.0 netmask 255.255.255.0 gw 192.176.7.150 
    route add -net 192.176.7.136 netmask 255.255.255.248 gw 192.176.7.150
    ```

    ```sh
    // Pada eden untuk memberi akses pada Garden dan SSS

- Melakukan setup pada DNS Server **( Eden )**
    - Melakukan instalasi pada bind9 -y dengan syntax 
        ```sh
        apt update
        apt install bind9 -y
        ```
    - melakukan konfigurasi pada file `/etc/bind/named.conf.options`
        ```sh
        echo '
        options {
                directory "/var/cache/bind";
                forwarders {
                        192.168.122.1;
                };
                allow-query { any; };
                auth-nxdomain no;    # conform to RFC1035
                listen-on-v6 { any; };
        };` > /etc/bind/named.conf.options
        ```
    - melakukan restart dengan 
        ```
        service bind9 restart
        ```
- Melakukan setup pada DHCP Server **( Eden )**
  - Melakukan instalasi dhcp server dengan syntax 
    ```sh
    apt update
    apt install isc-dhcp-server -y  
    ```
  - melakukan konfigurasi pada file `/etc/default/isc-dhcp-server`, dengan nilai sebagai berikut :
    ```sh
    echo '
    INTERFACES="eth0"' > /etc/default/isc-dhcp-server
    ```
  - melakukan konfigurasi pada file ` /etc/dhcp/dhcpd.conf`, dengan nilai sebagai berikut :
    ```
    #Forger
    subnet 192.176.7.0 netmask 255.255.255.128 {
        range 192.176.7.2 192.176.7.126;
        option routers 192.176.7.1;
        option broadcast-address 192.176.7.127; option domain-name-servers 192.176.7.130;
        default-lease-time 600;
        max-lease-time 7200;
    }
    #Desmond
    subnet 192.176.0.0 netmask 255.255.252.0 { 
        range 192.176.0.2 192.176.3.254;
        option routers 192.176.0.1;
        option broadcast-address 192.176.3.255; option domain-name-servers 192.176.7.130;
        default-lease-time 600; max-lease-time 7200;
    }

    #Blackbell
    subnet 192.176.4.0 netmask 255.255.254.0 { 
        range 192.176.4.2 192.176.5.254;
        option routers 192.176.4.1;
        option broadcast-address 192.176.5.255;
        option domain-name-servers 192.176.7.130;
        default-lease-time 600;
        max-lease-time 7200;
    }

    #Briar
    subnet 192.176.6.0 netmask 255.255.255.0 { 
        range 192.176.6.2 192.176.6.254;
        option routers 192.176.6.1;
        option broadcast-address 192.176.6.255; 
        option domain-name-servers 192.176.7.130;
        default-lease-time 600; max-lease-time 7200;
    }

    subnet 192.176.7.128 netmask 255.255.255.248 {
        option routers 192.176.7.129;
    }

    ```
  - Melakukan restart server dengan syntax :
    ```
    service isc-dhcp-server restart
    ```
- Melakukan setup pada DHCP RELAY **( Westalist dan ostania )**
  - melakukan instalasi dhcp-relay dengan syntax :
    ```
    apt update
    apt install isc-dhcp-relay -y
    ```
  - melakukan konfigurasi pada `/etc/default/isc-dhcp-relay`, dengan syntax :
    ```sh
    echo ` 
    SERVERS="192.176.7.131"
    INTERFACES="eth0 eth1 eth2 eth3"
    OPTIONS=""
    ` > /etc/default/isc-dhcp-relay
    ```
  - Melakukan restart dhcp-relay dengan syntax
    ```
    service isc-dhcp-relay restart
    ```
- Melakukan setup pada Web Server **( Garden dan SSS )**, dengan instalasi Apache2 dengan syntax :
    ```sh
    apt update
    apt install apache2 -y

    mkdir var cd var
    mkdir www
    cd www mkdir html
    cd html
    touch index.html
    cd /var/www/html/
    ```
### Soal 1 ###
Agar topologi yang kalian buat dapat mengakses keluar, kalian diminta untuk mengkonfigurasi Strix menggunakan iptables, tetapi Loid tidak ingin menggunakan MASQUERADE.

**Pembahasan**
melakukan konfigurasi pada **Strix**, dengan syntax :
```
iptables -t nat -A POSTROUTING -s 192.176.0.0/21 -o eth0 -j SNAT --to-source 192.168.122.213
```

**Testing**
![tesing1](/src/testing1.png)


### Soal 2 ###
Kalian diminta untuk melakukan drop semua TCP dan UDP dari luar Topologi kalian pada server yang merupakan DHCP Server demi menjaga keamanan.

**Pembahasan :**
melakuakn konfiguransi pada **WISE**, dengan syntax :
```sh
iptables -A FORWARD -d 192.176.7.128/29 -i eth0 -p tcp --dport 80 -j DROP
iptables -A FORWARD -d 192.176.7.128/29 -i eth0 -p udp --dport 80 -j DROP
```

**Testing**
![tesing2](/src/testing2.png)

### Soal 3 ###
Loid meminta kalian untuk membatasi DHCP dan DNS Server hanya boleh menerima maksimal 2 koneksi ICMP secara bersamaan menggunakan iptables, selebihnya didrop.

**Pembahsan**
Pada DHCP Server **(WISE)** dilakukan konvigurasi dengan syntax berikut :
``` sh
iptables -A INPUT -p icmp -m connlimit --connlimit-above 2 --connlimit-mask 0 -$
```
konfigurasi diatas akan melakukan reject bila terdapat ping lebih dari 3

**Testing**
- DHCP SERVER (WISE)
    ![3.1](/src/3.1.png)
    ![3.2](/src/3.2.png)
    ![3.3](/src/3.3.png)
- DNS SERVER (EDEN)
    ![3.4](/src/3.4.png)
    ![3.5](/src/3.5.png)
    ![3.6](/src/3.6.png)


### Soal 4 ###
Akses menuju Web Server hanya diperbolehkan disaat jam kerja yaitu Senin sampai Jumat pada pukul 07.00 - 16.00.

**Pembahasan :**

Melakukan pembatasan pada **Web Server**, yakni Garden dan SSS dengan menggunakan syntax berikut pada 
- DNS Server (Eden):
```sh
iptables -A INPUT -s 192.176.7.136/29 -m time --timestart 07:00 --timestop 16:0$ 
iptables -A INPUT -s 192.176.7.136/29 -j REJECT
```

- Node Garden dan SSS (Web Server)
```
iptables -A INPUT -m time --timestart 07:00 --timestop 16:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
iptables -A INPUT -j REJECT
```

**Testing**
![4.1](/src/4.1.png)

### Soal 5 ###
Karena kita memiliki 2 Web Server, Loid ingin Ostania diatur sehingga setiap request dari client yang mengakses Garden dengan port 80 akan didistribusikan secara bergantian pada SSS dan Garden secara berurutan dan request dari client yang mengakses SSS dengan port 443 akan didistribusikan secara bergantian pada Garden dan SSS secara berurutan.

**Pembahasan**
Melakukan konfigurasi berikut pada DNS Server **(Eden)** : 
```
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 192.176.7.138 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 192.176.7.138:80
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 192.176.7.138 -j DNAT --to-destination 192.176.7.139:80
iptables -A PREROUTING -t nat -p tcp --dport 443 -d 192.176.7.139 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 192.176.7.139:443
iptables -A PREROUTING -t nat -p tcp --dport 443 -d 192.176.7.139 -j DNAT --to-destination 192.176.7.138:443
```

**Soal 6**
Karena Loid ingin tau paket apa saja yang di-drop, maka di setiap node server dan router ditambahkan logging paket yang di-drop dengan standard syslog level.

**Pembahasan**
- Melakukan konfigurasi berikut pada DNS Server **(Eden)** dan DHCP SERVER **(Wise)**:
    ```sh
    iptables -N LOGGING
    iptables -A INPUT -p icmp -m connlimit --connlimit-above 2 --connlimit-mask 0 -$
    iptables -A LOGGING - LOG --log-prefix "IPTables-Dropped: "
    iptables -A LOGGING -j DROP

    ```

- Melakuakn restart `rsyslog` pada **(Eden)** dan DHCP SERVER **(Wise)**, menggunakan syntax :
    ```
    service rsyslog restart
    ```

**Testing**

 ![6.1](/src/6.1.png)

