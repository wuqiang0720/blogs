#### PCI格式：

  The PCI addresses must be defined in the following format: `XXXX:YY:ZZ.W` where:  
`XXXX` = domain, must always be **0000**  
`YY` = BusNumber  
`ZZ` = DeviceNumber  
`W` = FunctionNumber 

* racadm DELL:  
   > `racadm hwinventory | grep -B1 -A34 "Device Type = NIC"|grep -E "InstanceID|FunctionNumber|DeviceNumber|BusNumber"`
* redfish DELL:  
   > `curl -k -uroot:<passswd> https://x.x.x.x/redfish/v1/Systems/System.Embedded.1/EthernetInterfaces/NIC.Integrated.1-4-11`
* redfish iLO4:
   > `curl -s -k -u root:<passwd> https://x.x.x.x:/redfish/v1/Systems/1/NetworkAdapters/1/`

可以通过redfish API 或者racadm命令 获取如下参数：从而转化为PCI地址，
```bash
[InstanceID: NIC.Slot.1-1-1]
FunctionNumber = 0
DeviceNumber = 0
BusNumber = 131
[InstanceID: NIC.Slot.1-2-1]
FunctionNumber = 1
DeviceNumber = 0
BusNumber = 131
```
> [!NOTE]
> 这里查到的是10进制数，pci采用的是16进制需要转换一下。
> [SHELL数制转换](https://github.com/wuqiang0720/blogs/blob/main/linux/shell%20%E6%95%B0%E5%88%B6%E8%BD%AC%E6%8D%A2.md)  
> `root@ubuntu-focal:~# printf '%x\n' 131 //OUTPUT是 83 `

那么上面的信息转换为PCI地址就是:<br>
```
[InstanceID: NIC.Slot.1-1-1]      000:83:0:0 
[InstanceID: NIC.Slot.1-2-1]      000:83:0:1
```
