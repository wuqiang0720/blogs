![https://cr.console.aliyun.com/cn-hangzhou/instance/credentials]

```
root@ubuntu:~# docker login --username=wuqiang0720@126.com crpi-1a2va0tmixilfngp.cn-hangzhou.personal.cr.aliyuncs.com
Password:W********4

WARNING! Your credentials are stored unencrypted in '/root/.docker/config.json'.
Configure a credential helper to remove this warning. See
https://docs.docker.com/go/credential-store/

Login Succeeded
root@ubuntu:~#

root@ubuntu:~# docker tag sles15:15.5v1 crpi-1a2va0tmixilfngp.cn-hangzhou.personal.cr.aliyuncs.com/wuqiang0720/sles15:15.5v1


root@ubuntu:~# docker push crpi-1a2va0tmixilfngp.cn-hangzhou.personal.cr.aliyuncs.com/wuqiang0720/sles15:15.5v1
The push refers to repository [crpi-1a2va0tmixilfngp.cn-hangzhou.personal.cr.aliyuncs.com/wuqiang0720/sles15]
597fd2d336f6: Pushed
64e78f4664e5: Pushed
15.5v1: digest: sha256:993554e5d0be65f8a5943ae15452fb59092281158c14d3c56735aba3997717f5 size: 742
root@ubuntu:~#
root@ubuntu:~# docker tag ssr:v2 crpi-1a2va0tmixilfngp.cn-hangzhou.personal.cr.aliyuncs.com/wuqiang0720/ssr:v1
root@ubuntu:~#
root@ubuntu:~#
root@ubuntu:~# docker push crpi-1a2va0tmixilfngp.cn-hangzhou.personal.cr.aliyuncs.com/wuqiang0720/ssr:v1
The push refers to repository [crpi-1a2va0tmixilfngp.cn-hangzhou.personal.cr.aliyuncs.com/wuqiang0720/ssr]
bacd2012c693: Pushed
31d249e4e797: Pushed
51f17d0a36b1: Pushed
33da4cea74ee: Pushed
fffe76c64ef2: Pushed
v1: digest: sha256:10c5da9adaed7751f8057717ccde53a6f19f491b934d7f2bb63f9c0770c5e0b3 size: 1368
root@ubuntu:~#
```



