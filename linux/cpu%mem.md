### CPU: :smiley:
```
[root@root ~]# cat /proc/cpuinfo 
processor       : 0                 // 逻辑处理器的唯一标识符
vendor_id       : GenuineIntel      // CPU制造商，GenuineIntel表示是英特尔处理器
cpu family      : 6                 // CPU产品系列代号
model           : 79                // 表明CPU属于其系列中的哪一代号
model name      : Intel(R) Xeon(R) CPU E5-2682 v4 @ 2.50GHz    // CPU属于的名字、编号、主频
stepping        : 1                 // 步进编号，用来标识处理器的设计或制作版本，有助于控制和跟踪处理器的更改
microcode       : 0x1               // CPU微代码
cpu MHz         : 2494.220          // CPU的实际试用主频
cache size      : 40960 KB          // CPU二级cache大小
physical id     : 0                 // 物理CPU的标号，物理CPU就是硬件上真实存在的CPU
siblings        : 1                 // 一个物理CPU有几个逻辑CPU
core id         : 0                 // 一个物理CPU上的每个内核的唯一标识符，不同物理CPU的core id可以相同，因为每个CPU上的core id都从0开始标识
cpu cores       : 1                 // 指的是一个物理CPU有几个核
apicid          : 0                 // 用来区分不同逻辑核的编号，系统中每个逻辑核的此编号都不同
initial apicid  : 0
fpu             : yes               // 是否具有浮点运算单元
fpu_exception   : yes               // 是否支持浮点计算异常
cpuid level     : 13                // 执行cpuid指令前，eax寄存器中的值，不同cpuid指令会返回不同内容
wp              : yes               // 表明当前CPU是否在内核态支持对用户空间的写保护（Write Protection）
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl eagerfpu pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch ibrs ibpb stibp fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm rdseed adx smap xsaveopt spec_ctrl intel_stibp
bogomips        : 4988.44           // 在系统内核启动时粗略测算的CPU速度
clflush size    : 64                // 每次刷新缓存的大小单位
cache_alignment : 64                // 缓存地址对齐单位
address sizes   : 46 bits physical, 48 bits virtual // 可访问地址空间位数    
power management:                   // 电源管理相关
[root@localhost ~]# lscpu
Architecture:          x86_64            // 架构，这里的64指的位处理器
CPU op-mode(s):        32-bit, 64-bit    // CPU支持的模式：32位、64位
Byte Order:            Little Endian     // 字节排序的模式，常用小端模式
CPU(s):                32                // 逻辑CPU数量
On-line CPU(s) list:   0-31              // 在线的cpu数量 有些时候为了省电或者过热的时候，某些CPU会停止运行
Thread(s) per core:    2                 // 每个核心支持的线程数
Core(s) per socket:    8                 // 每颗物理cpu的核数
Socket(s):             2                 // 主板上插CPU的槽的数量，即物理cpu数量
NUMA node(s):          2
Vendor ID:             GenuineIntel      // cpu厂商ID
CPU family:            6                 // CPU系列
Model:                 69                // CPU型号    
Model name:            Intel(R) Core(TM) i5-4210U CPU @ 1.70GHz
Stepping:              1    
CPU MHz:               1704.097          // cpu主频
CPU max MHz:           2700.0000         
CPU min MHz:           800.0000
BogoMIPS:              4788.97           // MIPS是每秒百万条指令,Bogo是Bogus(伪)的意思，这里是估算MIPS值
Virtualization:        VT-x              // cpu支持的虚拟化技术
L1d cache:             32K               // 一级高速缓存 dcache 用来存储数据
L1i cache:             32K               // 一级高速缓存 icache 用来存储指令
L2 cache:              256K              // 二级缓存
L3 cache:              3072K             // 三级缓存 缓存速度上 L1 > L2 > L3 > DDR(内存)
NUMA node0 CPU(s):     0-3

```

### MEM： :relaxed:

```
[root@localhost ~]# cat /proc/meminfo 
MemTotal:       32656556 kB        // 可供系统支配的内存 （即物理内存减去一些预留位和内核的二进制代码大小）
MemFree:        13060828 kB        // LowFree与HighFree的总和，系统中未使用的内存
MemAvailable:   27306600 kB        // 应用程序可用内存，MemAvailable≈MemFree+Buffers+Cached，它与MemFree的关键区别点在于，MemFree是说的系统层面，MemAvailable是说的应用程序层面
Buffers:            2080 kB        // 缓冲区内存数，对原始磁盘块的临时存储，也就是用来缓存磁盘的数据，通常不会特别大 （20MB 左右）
Cached:         15397548 kB        // 缓存区内存数
SwapCached:            0 kB        // 交换文件中的已经被交换出来的内存。与 I/O 相关
Active:          9556388 kB        // 经常（最近）被使用的内存
Inactive:        8106580 kB        // 最近不常使用的内存。这很容易被系统移做他用
Active(anon):    3351300 kB        // 活跃的匿名内存（进程中堆上分配的内存,是用malloc分配的内存）
Inactive(anon):   823400 kB        // 不活跃的匿名内存
Active(file):    6205088 kB        // 活跃的与文件关联的内存（比如程序文件、数据文件所对应的内存页）
Inactive(file):  7283180 kB        // 不活跃的与文件关联的内存
Unevictable:           0 kB        // 不能被释放的内存页
Mlocked:               0 kB        // mlock()系统调用锁定的内存大小
SwapTotal:      16450556 kB        // 交换空间总大小
SwapFree:       16450556 kB        // 空闲的交换空间大小
Dirty:                12 kB        // 等待被写回到磁盘的大小
Writeback:             0 kB        // 正在被写回的大小
AnonPages:       2263468 kB        // 未映射页的大小
Mapped:           343264 kB        // 设备和文件映射大小
Shmem:           1911344 kB        // 已经被分配的共享内存大小
Slab:            1472540 kB        // 内核数据结构缓存大小
SReclaimable:    1189988 kB        // 可收回Slab的大小
SUnreclaim:       282552 kB        // 不可收回的Slab的大小
KernelStack:       17312 kB        // kernel消耗的内存
PageTables:        34020 kB        // 管理内存分页的索引表的大小
NFS_Unstable:          0 kB        // 不稳定页表的大小
Bounce:                0 kB        // 在低端内存中分配一个临时buffer作为跳转，把位于高端内存的缓存数据复制到此处消耗的内存
WritebackTmp:          0 kB        // 用于临时写回缓冲区的内存
CommitLimit:    32778832 kB        // 系统实际可分配内存总量
Committed_AS:    9836288 kB        // 当前已分配的内存总量
VmallocTotal:   34359738367 kB     // 虚拟内存大小
VmallocUsed:      392428 kB        // 已经被使用的虚拟内存大小
VmallocChunk:   34342156284 kB     // 在 vmalloc 区域中可用的最大的连续内存块的大小
HardwareCorrupted:     0 kB        // 删除掉的内存页的总大小(当系统检测到内存的硬件故障时)
AnonHugePages:   1552384 kB        // 匿名 HugePages 数量
CmaTotal:              0 kB        // 连续可用内存总数
CmaFree:               0 kB        // 空闲的连续可用内存
HugePages_Total:       0           // 预留HugePages的总个数
HugePages_Free:        0           // 尚未分配的 HugePages 数量
HugePages_Rsvd:        0           // 已经被应用程序分配但尚未使用的 HugePages 数量
HugePages_Surp:        0           // 这个值得意思是当开始配置了20个大页，现在修改配置为16，那么这个参数就会显示为4，一般不修改配置，这个值都是0
Hugepagesize:       2048 kB        // 每个大页的大小
DirectMap4k:      320240 kB        // 映射TLB为4kB的内存数量
DirectMap2M:     7972864 kB        // 映射TLB为2M的内存数量
DirectMap1G:    27262976 kB        // 映射TLB为1G的内存数量
	
[root@izwz91quxhnlkan8kjak5hz ~]# free -h
total        used        free      shared  buff/cache   available
Mem:           1.8G        332M        113M         17M        1.4G        1.3G
Swap:          1.0G          0B        1.0G

// 字段解析：
// Mem行：表示物理内存统计
// 1.  total 表示物理内存总量；
// 2.  used表示总计分配给缓存（包含buffers 与cache ）使用的数量，但其中可能部分缓存并未实际使用
// 3.  free表示未被分配的内存
// 4.  shared表示共享内存，一般系统不会用到
// 5.  buff/cache表示系统分配但未被使用的缓存大小
// 6.  available对应着/prco/meminfo 中的MemAvailable
// Swap行：表示硬盘上交换分区的使用情况
// 1. total表示交换分区上的内存总量
// 2. used表示已经使用的交换空间容量
// 3. free表示可用的交换空间容量
```


