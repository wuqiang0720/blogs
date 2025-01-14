```
root@ubuntu-focal:~# cat docker-compose.yaml
version: "3"
services:
  mariadb1:
      image: ewuiaqx/mariadb:10.5
      container_name: mariadb1
      network_mode: "host"
      restart: unless-stopped
      depends_on:
        - mariadb2
      environment:
          - MARIADB_ROOT_PASSWORD=123456
          - WSREP_CLUSTER_NAME=Galera_Cluster
      volumes:
          - /var/lib/docker_volume/mariadb1/conf:/etc/mysql
          - /var/lib/docker_volume/mariadb1/log:/var/log/mysql
          - /var/lib/docker_volume/mariadb1/data:/var/lib/mysql
      healthcheck:
        test: ["CMD", "/usr/local/bin/healthcheck_mariadb"]
        interval: 5s
        timeout: 2s
        retries: 3
      command:
       --wsrep_on=ON
       --wsrep_provider="/usr/lib/galera/libgalera_smm.so"
       --wsrep_cluster_address=gcomm://192.168.126.100:4567,192.168.126.100:4568,192.168.126.100:4569
       #  --wsrep-new-cluster

  mariadb2:
      image: ewuiaqx/mariadb:10.5
      container_name: mariadb2
      network_mode: "host"
      restart: unless-stopped
      # depends_on:
      #  - mariadb1
      environment:
          - MARIADB_ROOT_PASSWORD=123456
          - WSREP_CLUSTER_NAME=Galera_Cluster
      volumes:
          - /var/lib/docker_volume/mariadb2/conf:/etc/mysql
          - /var/lib/docker_volume/mariadb2/log:/var/log/mysql
          - /var/lib/docker_volume/mariadb2/data:/var/lib/mysql
      healthcheck:
        test: ["CMD", "/usr/local/bin/healthcheck_mariadb"]
        interval: 5s
        timeout: 2s
        retries: 3
      command:
       --wsrep_on=ON
       --wsrep_provider="/usr/lib/galera/libgalera_smm.so"
       --wsrep_cluster_address=gcomm://192.168.126.100:4567,192.168.126.100:4568,192.168.126.100:4569
       --wsrep-new-cluster
  mariadb3:
      image: ewuiaqx/mariadb:10.5
      container_name: mariadb3
      network_mode: "host"
      restart: unless-stopped
      depends_on:
        - mariadb2
      environment:
          - MARIADB_ROOT_PASSWORD=123456
          - WSREP_CLUSTER_NAME=Galera_Cluster
      volumes:
          - /var/lib/docker_volume/mariadb3/conf:/etc/mysql
          - /var/lib/docker_volume/mariadb3/log:/var/log/mysql
          - /var/lib/docker_volume/mariadb3/data:/var/lib/mysql
      healthcheck:
        test: ["CMD", "/usr/local/bin/healthcheck_mariadb"]
        interval: 5s
        timeout: 2s
        retries: 3
      command:
       --wsrep_on=ON
       --wsrep_provider="/usr/lib/galera/libgalera_smm.so"
       --wsrep_cluster_address=gcomm://192.168.126.100:4567,192.168.126.100:4568,192.168.126.100:4569
  haproxy:
      image: ewuiaqx/haproxy:3.0.5
      container_name: haproxy
      network_mode: "host"
      restart: unless-stopped
      depends_on:
       - mariadb1
       - mariadb2
       - mariadb3
      healthcheck:
        test: ["CMD", "/var/lib/haproxy/healthcheck"]
        interval: 5s
        timeout: 2s
        retries: 3
      volumes:
        -  /var/lib/docker_volume/haproxy/log:/var/log/haproxy
        -  /var/lib/docker_volume/haproxy/conf:/usr/local/etc/haproxy
```
如果不需要haproxy 去掉配置即可然后运行下面命令启动容器
docker-compose up -d

删除容器命令：
docker-compose down

查看logs命令：
docker-compose logs -f [container-name]

