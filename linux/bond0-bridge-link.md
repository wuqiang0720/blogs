```
Last login: Wed Jan 22 13:53:30 2025 from 192.168.126.1
ubuntu@ubuntu:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 00:15:5d:7e:01:09 brd ff:ff:ff:ff:ff:ff
    inet 192.168.126.10/24 brd 192.168.126.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::215:5dff:fe7e:109/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 00:15:5d:7e:01:0a brd ff:ff:ff:ff:ff:ff
4: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 00:15:5d:7e:01:0b brd ff:ff:ff:ff:ff:ff
ubuntu@ubuntu:~$ sudo ip link add bond0 type bond mode active-backup
ubuntu@ubuntu:~$ ip  a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 00:15:5d:7e:01:09 brd ff:ff:ff:ff:ff:ff
    inet 192.168.126.10/24 brd 192.168.126.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::215:5dff:fe7e:109/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 00:15:5d:7e:01:0a brd ff:ff:ff:ff:ff:ff
4: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 00:15:5d:7e:01:0b brd ff:ff:ff:ff:ff:ff
5: bond0: <BROADCAST,MULTICAST,MASTER> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff
ubuntu@ubuntu:~$ sudo ip link set eth1 master bond0
ubuntu@ubuntu:~$ sudo ip link set eth2 master bond0
ubuntu@ubuntu:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 00:15:5d:7e:01:09 brd ff:ff:ff:ff:ff:ff
    inet 192.168.126.10/24 brd 192.168.126.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::215:5dff:fe7e:109/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond0 state UP group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff permaddr 00:15:5d:7e:01:0a
4: eth2: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond0 state UP group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff permaddr 00:15:5d:7e:01:0b
5: bond0: <BROADCAST,MULTICAST,MASTER> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff
ubuntu@ubuntu:~$ cat /proc/net/bonding/bond0
Ethernet Channel Bonding Driver: v5.15.0-130-generic

Bonding Mode: fault-tolerance (active-backup)
Primary Slave: None
Currently Active Slave: eth1
MII Status: up
MII Polling Interval (ms): 0
Up Delay (ms): 0
Down Delay (ms): 0
Peer Notification Delay (ms): 0

Slave Interface: eth1
MII Status: up
Speed: 10000 Mbps
Duplex: full
Link Failure Count: 0
Permanent HW addr: 00:15:5d:7e:01:0a
Slave queue ID: 0

Slave Interface: eth2
MII Status: up
Speed: 10000 Mbps
Duplex: full
Link Failure Count: 0
Permanent HW addr: 00:15:5d:7e:01:0b
Slave queue ID: 0
ubuntu@ubuntu:~$ sudo ip link set bond0 up
ubuntu@ubuntu:~$ ip a s
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 00:15:5d:7e:01:09 brd ff:ff:ff:ff:ff:ff
    inet 192.168.126.10/24 brd 192.168.126.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::215:5dff:fe7e:109/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond0 state UP group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff permaddr 00:15:5d:7e:01:0a
4: eth2: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond0 state UP group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff permaddr 00:15:5d:7e:01:0b
5: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff
    inet6 fe80::b4d2:4dff:fe9a:a09b/64 scope link
       valid_lft forever preferred_lft forever
ubuntu@ubuntu:~$ sudo ip link add link bond0 name bond0.4071 type vlan id 4071
ubuntu@ubuntu:~$ sudo ip addr add 192.168.241.11/24 dev bond0.4071
ubuntu@ubuntu:~$ sudo ip link set bond0.4071 up
ubuntu@ubuntu:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 00:15:5d:7e:01:09 brd ff:ff:ff:ff:ff:ff
    inet 192.168.126.10/24 brd 192.168.126.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::215:5dff:fe7e:109/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond0 state UP group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff permaddr 00:15:5d:7e:01:0a
4: eth2: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond0 state UP group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff permaddr 00:15:5d:7e:01:0b
5: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff
    inet6 fe80::b4d2:4dff:fe9a:a09b/64 scope link
       valid_lft forever preferred_lft forever
6: bond0.4071@bond0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff
    inet 192.168.241.11/24 scope global bond0.4071
       valid_lft forever preferred_lft forever
    inet6 fe80::b4d2:4dff:fe9a:a09b/64 scope link tentative
       valid_lft forever preferred_lft forever
ubuntu@ubuntu:~$ sudo ip link add br-fw-admin type bridge
ubuntu@ubuntu:~$ sudo ip link set dev bond0 master br-fw-admin
ubuntu@ubuntu:~$ sudo ip addr add 192.168.0.19/23 dev br-fw-admin
ubuntu@ubuntu:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 00:15:5d:7e:01:09 brd ff:ff:ff:ff:ff:ff
    inet 192.168.126.10/24 brd 192.168.126.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::215:5dff:fe7e:109/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond0 state UP group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff permaddr 00:15:5d:7e:01:0a
4: eth2: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond0 state UP group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff permaddr 00:15:5d:7e:01:0b
5: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-fw-admin state UP group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff
    inet6 fe80::b4d2:4dff:fe9a:a09b/64 scope link
       valid_lft forever preferred_lft forever
6: bond0.4071@bond0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff
    inet 192.168.241.11/24 scope global bond0.4071
       valid_lft forever preferred_lft forever
    inet6 fe80::b4d2:4dff:fe9a:a09b/64 scope link
       valid_lft forever preferred_lft forever
7: br-fw-admin: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 1e:cc:2c:dc:d4:68 brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.19/23 scope global br-fw-admin
       valid_lft forever preferred_lft forever
ubuntu@ubuntu:~$ sudo ip link set br-fw-admin up
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 00:15:5d:7e:01:09 brd ff:ff:ff:ff:ff:ff
    inet 192.168.126.10/24 brd 192.168.126.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::215:5dff:fe7e:109/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond0 state UP group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff permaddr 00:15:5d:7e:01:0a
4: eth2: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc mq master bond0 state UP group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff permaddr 00:15:5d:7e:01:0b
5: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue master br-fw-admin state UP group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff
    inet6 fe80::b4d2:4dff:fe9a:a09b/64 scope link
       valid_lft forever preferred_lft forever
6: bond0.4071@bond0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether b6:d2:4d:9a:a0:9b brd ff:ff:ff:ff:ff:ff
    inet 192.168.241.11/24 scope global bond0.4071
       valid_lft forever preferred_lft forever
    inet6 fe80::b4d2:4dff:fe9a:a09b/64 scope link
       valid_lft forever preferred_lft forever
7: br-fw-admin: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 1e:cc:2c:dc:d4:68 brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.19/23 scope global br-fw-admin
       valid_lft forever preferred_lft forever
    inet6 fe80::1ccc:2cff:fedc:d468/64 scope link
       valid_lft forever preferred_lft forever
ubuntu@ubuntu:~$ history

```
