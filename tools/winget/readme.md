安装软件指定路径:  
`[ERICSSON+ewuiaqx.E-5CG22831M4] ⮞ winget install <package_id> --location "D:\Apps\MyProgram"`  
卸载软件:  
`[ERICSSON+ewuiaqx.E-5CG22831M4] ⮞ winget uninstall --id ksnip.ksnip --silent`  



批量安装:   
先导出pkg列表并生成json文件(有些软件不能导出来):   
`winget export -o packages.json`  
然后安装:   
`winget import --import-file packages.json --accept-package-agreements --accept-source-agreements` 

