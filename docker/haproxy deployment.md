```
docker pull swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/library/haproxy
mkdir -p /var/lib/docker_volume/docker/{conf,log}
root@ubuntu-focal:/var/lib/docker_volume/haproxy/conf# cat haproxy.cfg
global
    daemon
    log /dev/log local1
    maxconn 40000
defaults
    log global
    option redispatch
    retries 3
    timeout http-request 10s
    timeout queue 1m
    timeout connect 10s
    timeout client 5m
    timeout server 5m
    timeout check 10s
    balance roundrobin
    maxconn 10000
frontend mariadb_front
    mode tcp
    option clitcpka
    timeout client 3600s
    option tcplog
    bind 192.168.126.100:3305
    default_backend mariadb_back

backend mariadb_back
    mode tcp
    option srvtcpka
    timeout server 3600s
    option mysql-check user haproxy post-41
    server ubuntu01 192.168.126.100:3306 check inter 2000 rise 2 fall 5
    server ubuntu02 192.168.126.100:3307 check inter 2000 rise 2 fall 5 backup
    server ubuntu03 192.168.126.100:3308 check inter 2000 rise 2 fall 5 backup

docker run -itd --name haproxy --net=host -e interface=eth0 --restart unless-stopped -v /var/lib/docker_volume/haproxy/conf:/usr/local/etc/haproxy -v /var/lib/docker_volume/haproxy/log:/var/log/haproxy a5cd2e6f7c97![image](https://github.com/user-attachments/assets/f552b5a5-f7b4-437e-81e7-fb0415b76f89)
 mysql -uroot -p123456 -h192.168.126.100 -P 3305 -e "SHOW STATUS LIKE 'wsrep_cluster%'"
mysql: [Warning] Using a password on the command line interface can be insecure.
+----------------------------+--------------------------------------+
| Variable_name              | Value                                |
+----------------------------+--------------------------------------+
| wsrep_cluster_weight       | 3                                    |
| wsrep_cluster_capabilities |                                      |
| wsrep_cluster_conf_id      | 3                                    |
| wsrep_cluster_size         | 3                                    |
| wsrep_cluster_state_uuid   | 1315a75c-b917-11ef-bdb8-3e60114cb84b |
| wsrep_cluster_status       | Primary                              |
+----------------------------+--------------------------------------+
```
