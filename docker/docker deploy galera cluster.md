OS：ubuntu-focal
Mariadb version：10.5
下载mariadb镜像
```
docker pull swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/mariadb

mkdir /var/lib/docker_volume

mkdir /var/lib/docker_volume/mariadb[1-3]

mkdir /var/lib/docker_volume/mariadb{1,2,3}/{log,conf,data}


     docker run -d --name mariadb1  \
       --restart unless-stopped   \
       --health-cmd="/usr/local/bin/healthcheck_mariadb" \
       --health-interval=5s \
       --health-retries=3 \
       --health-timeout=2s \
       --net=host -e interface=eth0   \
       -e MYSQL_ROOT_PASSWORD=123456 \
       -e WSREP_CLUSTER_NAME=Galera_Cluster \
       -v /var/lib/docker_volume/mariadb1/conf:/etc/mysql \
       -v /var/lib/docker_volume/mariadb1/data:/var/lib/mysql \
       -v /var/lib/docker_volume/mariadb1/log:/var/log/mysql \
        dff3e80682c6\
       --wsrep_on=ON \
       --wsrep_provider="/usr/lib/galera/libgalera_smm.so"  \
       --wsrep_cluster_address=gcomm://192.168.126.100:4567,192.168.126.100:4568,192.168.126.100:4569  \
       --wsrep-new-cluster
  
     docker run -d --name mariadb2\
       --restart unless-stopped \
       --health-cmd="/usr/local/bin/healthcheck_mariadb" \
       --health-interval=5s \
       --health-retries=3 \
       --health-timeout=2s \
       --net=host -e interface=eth0 \
       -e MYSQL_ROOT_PASSWORD=123456 \
       -e WSREP_CLUSTER_NAME=Galera_Cluster \
       -v /var/lib/docker_volume/mariadb2/conf:/etc/mysql \
       -v /var/lib/docker_volume/mariadb2/log:/var/log/mysql \
       -v /var/lib/docker_volume/mariadb2/data:/var/lib/mysql \
        dff3e80682c6\
       --wsrep_on=ON \
       --wsrep_provider="/usr/lib/galera/libgalera_smm.so"  \
       --wsrep_cluster_address=gcomm://192.168.126.100:4567,192.168.126.100:4568,192.168.126.100:4569 
  
     docker run -d --name mariadb3  \
       --restart unless-stopped  \
       --health-cmd="/usr/local/bin/healthcheck_mariadb" \
       --health-interval=5s \
       --health-retries=3 \
       --health-timeout=2s \
       --net=host -e interface=eth0   \
       -e MYSQL_ROOT_PASSWORD=123456 \
       -e WSREP_CLUSTER_NAME=Galera_Cluster \
       -v /var/lib/docker_volume/mariadb3/conf:/etc/mysql \
       -v /var/lib/docker_volume/mariadb3/log:/var/log/mysql \
       -v /var/lib/docker_volume/mariadb3/data:/var/lib/mysql \
        dff3e80682c6\
       --wsrep_on=ON \
       --wsrep_provider="/usr/lib/galera/libgalera_smm.so"  \
       --wsrep_cluster_address=gcomm://192.168.126.100:4567,192.168.126.100:4568,192.168.126.100:4569 


第二次重启的话需要在master上做如下的操作：否则报错如下
2024-12-13 10:02:19 0 [Note] WSREP: Start replication
2024-12-13 10:02:19 0 [Note] WSREP: Connecting with bootstrap option: 1
2024-12-13 10:02:19 0 [Note] WSREP: Setting GCS initial position to 00000000-0000-0000-0000-000000000000:-1
2024-12-13 10:02:19 0 [ERROR] WSREP: It may not be safe to bootstrap the cluster from this node. It was not the last one to leave the cluster and may not contain all the updates. To force cluster bootstrap with this node, edit the grastate.dat file manually and set safe_to_bootstrap to 1 .
2024-12-13 10:02:19 0 [ERROR] WSREP: wsrep::connect(gcomm://192.168.126.100:4567,192.168.126.100:4568,192.168.126.100:4569) failed: 7
2024-12-13 10:02:19 0 [ERROR] Aborting


sed -i "/safe_to_bootstrap/s/0/1/" /var/lib/docker_volume/mariadb1/data/grastate.dat
docker rm --force mariadb1 mariadb2 mariadb2
rm -rf /var/lib/docker_volume/mariadb*/data/*


root@ubuntu-focal:~# cat /var/lib/docker_volume/mariadb1/conf/my.cnf        < <  这个文件名字竟然还不能错！
[client]
default-character-set = utf8

[mysql]
default-character-set = utf8

[mysqld]
unix_socket = OFF
basedir = /usr
bind-address = 192.168.126.100
port = 3306
skip-name-resolve = ON
binlog_format = ROW
expire_logs_days = 14
default-storage-engine = innodb
innodb_autoinc_lock_mode = 2
collation-server = utf8_general_ci
init-connect = SET NAMES utf8
character-set-server = utf8
datadir = /var/lib/mysql/
ignore_db_dirs = lost+found
wsrep_cluster_address = gcomm://192.168.126.100:4567,192.168.126.100:4568,192.168.126.100:4569
wsrep_node_address = 192.168.126.100:4567
wsrep_provider = /usr/lib/galera/libgalera_smm.so
wsrep_cluster_name = openstack
wsrep_node_name = ubuntu-focal
wsrep_sst_method = mariabackup
wsrep_sst_auth = root:123456
wsrep_slave_threads = 4
#wsrep_notify_cmd = /usr/local/bin/wsrep-notify.sh
wsrep_on = ON
max_connections = 65535
key_buffer_size = 64M
max_heap_table_size = 64M
tmp_table_size = 64M
innodb_buffer_pool_size = 8192M
innodb_lock_schedule_algorithm = FCFS
innodb_print_all_deadlocks = ON

[server]
pid-file = /var/lib/mysql/mariadb.pid

[sst]

root@ubuntu-focal:~# cat /var/lib/docker_volume/mariadb2/conf/my.cnf
[client]
default-character-set = utf8

[mysql]
default-character-set = utf8

[mysqld]
unix_socket = OFF
basedir = /usr
bind-address = 192.168.126.100
port = 3307
skip-name-resolve = ON
binlog_format = ROW
expire_logs_days = 14
default-storage-engine = innodb
innodb_autoinc_lock_mode = 2
collation-server = utf8_general_ci
init-connect = SET NAMES utf8
character-set-server = utf8
datadir = /var/lib/mysql/
ignore_db_dirs = lost+found
wsrep_cluster_address = gcomm://192.168.126.100:4567,192.168.126.100:4568,192.168.126.100:4569
wsrep_node_address = 192.168.126.100:4568
wsrep_provider = /usr/lib/galera/libgalera_smm.so
wsrep_cluster_name = openstack
wsrep_node_name = ubuntu-focal
wsrep_sst_method = mariabackup
wsrep_sst_auth = root:123456
wsrep_slave_threads = 4
#wsrep_notify_cmd = /usr/local/bin/wsrep-notify.sh
wsrep_on = ON
max_connections = 65535
key_buffer_size = 64M
max_heap_table_size = 64M
tmp_table_size = 64M
innodb_buffer_pool_size = 8192M
innodb_lock_schedule_algorithm = FCFS
innodb_print_all_deadlocks = ON

[server]
pid-file = /var/lib/mysql/mariadb.pid

[sst]

root@ubuntu-focal:~# cat /var/lib/docker_volume/mariadb3/conf/my.cnf
[client]
default-character-set = utf8

[mysql]
default-character-set = utf8

[mysqld]
unix_socket = OFF
basedir = /usr
bind-address = 192.168.126.100
port = 3308
skip-name-resolve = ON
binlog_format = ROW
expire_logs_days = 14
default-storage-engine = innodb
innodb_autoinc_lock_mode = 2
collation-server = utf8_general_ci
init-connect = SET NAMES utf8
character-set-server = utf8
datadir = /var/lib/mysql/
ignore_db_dirs = lost+found
wsrep_cluster_address = gcomm://192.168.126.100:4567,192.168.126.100:4568,192.168.126.100:4569
wsrep_node_address = 192.168.126.100:4569
wsrep_provider = /usr/lib/galera/libgalera_smm.so
wsrep_cluster_name = openstack
wsrep_node_name = ubuntu-focal
wsrep_sst_method = mariabackup
wsrep_sst_auth = root:123456
wsrep_slave_threads = 4
#wsrep_notify_cmd = /usr/local/bin/wsrep-notify.sh
wsrep_on = ON
max_connections = 65535
key_buffer_size = 64M
max_heap_table_size = 64M
tmp_table_size = 64M
innodb_buffer_pool_size = 8192M
innodb_lock_schedule_algorithm = FCFS
innodb_print_all_deadlocks = ON

[server]
pid-file = /var/lib/mysql/mariadb.pid

[sst]
 
----------
root@ubuntu-focal:~# mysql -uroot -p123456 -h192.168.126.100 -P 3306 -e "SHOW STATUS LIKE 'wsrep_cluster%'"
mysql: [Warning] Using a password on the command line interface can be insecure.
+----------------------------+--------------------------------------+
| Variable_name              | Value                                |
+----------------------------+--------------------------------------+
| wsrep_cluster_weight       | 3                                    |
| wsrep_cluster_capabilities |                                      |
| wsrep_cluster_conf_id      | 3                                    |
| wsrep_cluster_size         | 3                                    |
| wsrep_cluster_state_uuid   | b5abd1cb-b902-11ef-9c24-27b212898fe8 |
| wsrep_cluster_status       | Primary                              |
+----------------------------+--------------------------------------+
root@ubuntu-focal:~# mysql -uroot -p123456 -h192.168.126.100 -P 3307 -e "SHOW STATUS LIKE 'wsrep_cluster%'"
mysql: [Warning] Using a password on the command line interface can be insecure.
+----------------------------+--------------------------------------+
| Variable_name              | Value                                |
+----------------------------+--------------------------------------+
| wsrep_cluster_weight       | 3                                    |
| wsrep_cluster_capabilities |                                      |
| wsrep_cluster_conf_id      | 3                                    |
| wsrep_cluster_size         | 3                                    |
| wsrep_cluster_state_uuid   | b5abd1cb-b902-11ef-9c24-27b212898fe8 |
| wsrep_cluster_status       | Primary                              |
+----------------------------+--------------------------------------+
root@ubuntu-focal:~# mysql -uroot -p123456 -h192.168.126.100 -P 3308 -e "SHOW STATUS LIKE 'wsrep_cluster%'"
mysql: [Warning] Using a password on the command line interface can be insecure.
+----------------------------+--------------------------------------+
| Variable_name              | Value                                |
+----------------------------+--------------------------------------+
| wsrep_cluster_weight       | 3                                    |
| wsrep_cluster_capabilities |                                      |
| wsrep_cluster_conf_id      | 3                                    |
| wsrep_cluster_size         | 3                                    |
| wsrep_cluster_state_uuid   | b5abd1cb-b902-11ef-9c24-27b212898fe8 |
| wsrep_cluster_status       | Primary                              |
+----------------------------+--------------------------------------+
root@ubuntu-focal:~#

```
