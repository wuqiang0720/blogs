
WIN + R 管理员运行CMD
输入如下命令5000天  
`reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v FlightSettingsMaxPauseDays /t reg_dword /d 5000 /f`

或者
CMD + R 打开 services.msc 找到如下服务并禁止更新
![windows update](https://github.com/wuqiang0720/PicGo_img/blob/master/windows%20update.png?raw=true)

