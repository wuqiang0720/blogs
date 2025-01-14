1. 安装相关软件包
---
`sudo apt install libguestfs-tools    //virt-custiomize     或者guestfish 命令`

2. 修改普通用户密码
---
```
ubuntu@ubuntu:~$ sudo virt-customize -a cirros-0.6.2-x86_64-disk.img --password cirros:password:123456
[sudo] password for ubuntu:
[   0.0] Examining the guest ...
[  46.9] Setting a random seed
[  47.3] Setting passwords
virt-customize: warning: password: using insecure md5 password encryption
for guest of type unknown version 0.6.
If this is incorrect, use --password-crypto option and file a bug.
[  56.4] Finishing off
```
 
3. 修改root用户名密码
---
```
ubuntu@ubuntu:~$ sudo virt-customize -a cirros-0.6.2-x86_64-disk.img --root-password password:123456
[   0.0] Examining the guest ...
[  36.1] Setting a random seed
[  36.4] Setting passwords
virt-customize: warning: password: using insecure md5 password encryption
for guest of type unknown version 0.6.
If this is incorrect, use --password-crypto option and file a bug.
[  43.7] Finishing off
```
