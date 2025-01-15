> [!NOTE]
> `Background:`   
> 给虚拟机`/etc/sudoers` 添加audit log配置，但是文件权限不足，修改了文件权限，同时因为网络问题退出了session，从而不能sudo 到 root用户了！

> [!TIP]
> 事后我们查询root的密码是被锁的状态并且禁止root登录：
```
[ubuntu@root ~]$ sudo passwd --status root
root L 08/13/2024 -1 -1 -1 -1
[ubuntu@root ~]$ sudo cat /etc/passwd | grep root
root:x:0:0:root:/root:/bin/bash
```




```bash
root@ubuntu-focal:~# virsh destroy vm-name
root@ubuntu-focal:~# modprobe nbd
root@ubuntu-focal:~# lsblk -l /dev/nbd0
lsblk: /dev/nbd0: not a block device

root@ubuntu-focal:~# qemu-nbd --connect=/dev/nbd0 /home/ubuntu/cirros-0.6.2-x86_64-disk.img
root@ubuntu-focal:~#
root@ubuntu-focal:~#
root@ubuntu-focal:~# lsblk -l /dev/nbd0
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
nbd0     43:0    0  112M  0 disk
nbd0p1   43:1    0  103M  0 part /mnt
nbd0p15  43:15   0    8M  0 part
root@ubuntu-focal:~# mount /dev/nbd0p1 /mnt/
root@ubuntu-focal:~# ll /mnt/
total 28
drwxr-xr-x  4 root root  4096 May 31  2023 ./
drwxr-xr-x 20 root root  4096 Dec 12 22:06 ../
drwxr-xr-x  3 root root  4096 May 31  2023 boot/
lrwxrwxrwx  1 root root    33 May 31  2023 initrd.img -> boot/initrd.img-5.15.0-71-generic
drwx------  2 root root 16384 May 31  2023 lost+found/
lrwxrwxrwx  1 root root    30 May 31  2023 vmlinuz -> boot/vmlinuz-5.15.0-71-generic
root@ubuntu-focal:~#
root@ubuntu-focal:~# umount /mnt
root@ubuntu-focal:~# ll /mnt/
total 8
drwxr-xr-x  2 root root 4096 Mar 15  2023 ./
drwxr-xr-x 20 root root 4096 Dec 12 22:06 ../
root@ubuntu-focal:~# qemu-nbd --disconnect /dev/nbd0
/dev/nbd0 disconnected
root@ubuntu-focal:~#

root@ubuntu-focal:~# virsh start vm-name
```



```
root@ubuntu-focal:~# man passwd
root@ubuntu-focal:~# man shadow
       -S, --status
           Display account status information. The status information consists of 7 fields. The first field is the user's login name. The second field indicates if the user account has a locked
           password (L), has no password (NP), or has a usable password (P). The third field gives the date of the last password change. The next four fields are the minimum age, maximum age,
           warning period, and inactivity period for the password. These ages are expressed in days.

       -u, --unlock
           Unlock the password of the named account. This option re-enables a password by changing the password back to its previous value (to the value before using the -l option).

```
