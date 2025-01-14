|  目的   | rpm 用法      |dpkg 用法 |
|-------| ----------- | ----------- |
|安装指定套件| rpm -i pkgfile.rpm | dpkg -i pkgfile.deb     |
|显示所有已安装的套件名称|rpm -qa	|dpkg -l (小写 L)|
|显示套件包含的所有档案|rpm -ql pkgname (小写 L)	|dpkg -L pkgname|
|显示特定档案所属套件名称|rpm -qf /path/to/file	|dpkg -S /path/to/file|
|查询套件档案资讯|rpm -qip pkgfile.rpm (显示套件资讯)<br> rpm-qlp pkgfile.rpm (小写 L,显示套件内所有档案)	|dpkg -I pkgfile.deb (大写 I) <br> dpkg-c pkgfile.deb |
|显示指定套件是否安装|rpm -q pkgname (只显示套件名称) <br> rpm -qi pkgname (显示套件资讯) | dpkg -l pkgname (小写 L,只列出简洁资讯) <br> dpkg -s pkgname (显示详细资讯) <br> dpkg -p pkgname (显示详细资讯)|
|移除指定套件|rpm -e pkgname| dpkg -r pkgname (会留下套件设定档) <br> dpkg -P pkgname (完全移除)|





|安装源操作：|zypper+ 参数|
|-------| ----------- |
|repos|lr 列出所有定义的安装源。|
|addrepo|ar 添加一个新的安装源。|
|removerepo|rr 删除指定的安装源。|
|renamerepo| nr 重命名指定的安装源。|
|modifyrepo| mr 修改指定的安装源。|
|refresh|ref 刷新所有安装源。|
|clean |清除本地缓存。|


