1. 安装软件包  
`sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst libguestfs-tools`


3. 开启并设置开机启动libvirt  
`ubuntu@ubuntu:~$ sudo systemctl start libvirtd`  
`ubuntu@ubuntu:~$ sudo systemctl enable libvirtd`

3. 设置network  
    ```
    ubuntu@ubuntu:~$ sudo virsh net-list
     Name      State    Autostart   Persistent
    --------------------------------------------
     default   active   yes         yes
    
    sudo virsh net-destory default
    sudo virsh net-undefine default
    
    cat >fn-management-static_ip.xml<<EOF
    <network>
      <name>fn-management</name>
      <forward mode='nat'>
        <nat>
          <port start='1024' end='65535'/>
        </nat>
      </forward>
      <bridge name='virbr1' stp='on' delay='0'/>
      <ip address='GW-IP' netmask='MASK'>
        <dhcp>
          <range start='XXX' end='XXX'/>   
          <host mac='52:54:00:d0:be:01' name='M' ip='X.X.X.X'/>
          <host mac='52:54:00:d0:be:02' name='S1' ip='X.X.X.X'/>
          <host mac='52:54:00:d0:be:03' name='S2' ip='X.X.X.X'/>
        </dhcp>
      </ip>
    </network>
    EOF
    
    virsh net-define --file fn-management-static_ip.xml
    virsh net-start --network fn-management
    virsh net-autostart --network fn-management
    ```

4. 创建虚拟机
   ```
   virt-install --virt-type qemu --name fn-M --memory 2048 --vcpus 2 --disk /var/lib/libvirt/qemu/xxxM.qcow2,format=qcow2,bus=virtio,size=10 --import --os-variant ubuntu20.04 --noautoconsole --network network=fn-management,mac=52:54:00:d0:be:01
   virt-install  --virt-type qemu --name fn-S1 --memory 2048 --vcpus 2 --disk /var/lib/libvirt/qemu/xxxS1.qcow2,format=qcow2,bus=virtio,size=10 --import --os-variant ubuntu20.04 --noautoconsole --network network=fn-management,mac=52:54:00:d0:be:02
   virt-install --virt-type qemu --name fn-S2 --memory 2048 --vcpus 2 --disk /var/lib/libvirt/qemu/xxxS2.qcow2,format=qcow2,bus=virtio,size=10 --import --os-variant ubuntu20.04 --noautoconsole --network network=fn-management,mac=52:54:00:d0:be:03
   ```
