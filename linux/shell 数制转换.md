[^1]: ssssssssssssssssssseeeeee

*16进制的`0x`不可以省略。*
#### 10进制转16进制：
```bash
root@ubuntu-focal:~# printf '%x\n' 131
83
```
#### 16进制转10进制：
```bash
root@ubuntu-focal:~# printf '%d\n' 0x83
131
```
#### 16进制转8进制：
```bash
root@ubuntu-focal:~# printf '%o\n' 0x83
203
```
#### 8进制转10进制：
```bash
root@ubuntu-focal:~# echo $((8#17))
15
```
#### 2进制转10进制：
```bash
root@ubuntu-focal:~# echo $((2#1111))
15
```
