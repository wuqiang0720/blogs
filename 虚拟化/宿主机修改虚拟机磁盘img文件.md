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
