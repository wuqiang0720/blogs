
```
root@ubuntu:/home/ubuntu/dockerfile# ll
total 16
drwxrwxr-x 2 ubuntu ubuntu 4096 Jun  2 08:08 ./
drwxr-x--- 7 ubuntu ubuntu 4096 Jun  2 07:59 ../
-rw-rw-r-- 1 ubuntu ubuntu 1423 Jun  2 08:08 dockerfile
-rw-rw-r-- 1 ubuntu ubuntu  595 Jun  2 07:56 shadowsocks.json
root@ubuntu:/home/ubuntu/dockerfile# cat *
# Dockerfile for ShadowsocksR
# https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh

FROM swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/ubuntu:focal

LABEL maintainer="Qiang Wu wuqiang07200@gmail.com>"

# prepare
RUN apt-get update \
  && apt-get install -y procps \
  && apt-get install -y wget \
  && apt-get install -y vim \
  && rm -rf /var/lib/apt/lists/* \
  && export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/local/games:/usr/games

# install ssr
RUN cd /usr/local \
  && mkdir ssr \
  && cd ssr \
  && wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh \
  && chmod +x shadowsocksR.sh \
  && \n | ./shadowsocksR.sh 2>&1 | tee shadowsocksR.log \
  && \n; exit 0

# ssr configuration
COPY shadowsocks.json /etc/

# ssr script
RUN cd /usr/local/ssr \
  # fake log
  && touch fake_log.log \
  # start.sh
  && touch start.sh \
  && echo 'python /usr/local/shadowsocks/server.py -c /etc/shadowsocks.json -d start && tail -f /usr/local/ssr/fake_log.log' > start.sh \
  && chmod 775 start.sh \
  # stop.sh
  && touch stop.sh \
  && echo 'python /usr/local/shadowsocks/server.py -c /etc/shadowsocks.json -d stop' > stop.sh \
  && chmod 775 stop.sh \
  # restart.sh
  && touch restart.sh \
  && echo './stop.sh && ./start.sh' > restart.sh \
  && chmod 775 restart.sh

ENTRYPOINT ["sh", "/usr/local/ssr/start.sh"]
{
   "server":"0.0.0.0",
   "server_ipv6":"[::]",
   "local_address":"127.0.0.1",
   "local_port":1080,
   "port_password":{
       "9000":"xxxxxx",
       "9001":{"password":"xxxxxx", "protocol":"auth_chain_a", "obfs":"tls1.2_ticket_auth", "obfs_param":""},
       "9002":{"password":"xxxxxx", "protocol":"auth_chain_a", "obfs":"tls1.2_ticket_auth", "obfs_param":""}
       // ...
   },
   "timeout":120,
   "method":"chacha20",
   "protocol":"origin",
   "protocol_param":"",
   "obfs":"plain",
   "obfs_param":"",
   "redirect":"",
   "dns_ipv6":false,
   "fast_open":false,
   "workers":1
}
root@ubuntu:/home/ubuntu/dockerfile# docker build -t ssr:v1 .
[+] Building 174.3s (10/10) FINISHED                                                                                                                                             docker:default
 => [internal] load build definition from dockerfile                                                                                                                                       0.0s
 => => transferring dockerfile: 1.46kB                                                                                                                                                     0.0s
 => [internal] load metadata for swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/ubuntu:focal                                                                                           0.4s
 => [internal] load .dockerignore                                                                                                                                                          0.0s
 => => transferring context: 2B                                                                                                                                                            0.0s
 => CACHED [1/5] FROM swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/ubuntu:focal@sha256:d690b2509d3d76dd9c83d2a923a3670d9f8b163412b25902504052d4fd6b396d                              0.0s
 => [internal] load build context                                                                                                                                                          0.0s
 => => transferring context: 38B                                                                                                                                                           0.0s
 => [2/5] RUN apt-get update   && apt-get install -y procps   && apt-get install -y wget   && apt-get install -y vim   && rm -rf /var/lib/apt/lists/*   && export PATH=/usr/local/sbin:/  34.7s
 => [3/5] RUN cd /usr/local   && mkdir ssr   && cd ssr   && wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh   && chmo  136.4s
 => [4/5] COPY shadowsocks.json /etc/                                                                                                                                                      0.1s
 => [5/5] RUN cd /usr/local/ssr   && touch fake_log.log   && touch start.sh   && echo 'python /usr/local/shadowsocks/server.py -c /etc/shadowsocks.json -d start && tail -f /usr/local/ss  0.3s
 => exporting to image                                                                                                                                                                     2.1s
 => => exporting layers                                                                                                                                                                    2.1s
 => => writing image sha256:df336caf0fb34bf8d261ab4cba43b769db72e6408c06cb04360903bf9d37e804                                                                                               0.0s
 => => naming to docker.io/library/ssr:v1                                                                                                                                                  0.0s
root@ubuntu:/home/ubuntu/dockerfile# docker run -itd --name ssr -p 9000:9000 -p 9001:9001 -p 9002:9002 ssr:v1

```
