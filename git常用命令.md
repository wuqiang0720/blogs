### log 记录查看
```sh
查看提交记录：
git log --pretty=oneline
查看某个commit的修改内容：
git show commit-id
回滚的commit版本：
git reset --hard HEAD^         回退到上个版本
git reset --hard HEAD~3        回退到前3次提交之前，以此类推，回退到n次提交之前
git reset --hard commit-id     退到/进到 指定commit的id码
在Git中，用【HEAD】表示当前版本
上一个版本就是【HEAD^】，上上一个版本就是【HEAD^^】，当然往上100个版本写100个^比较容易数不过来，所以写成【HEAD~100】
```



### 远端提交github
1. 导航到你存储 Markdown 文件的文件夹：  
   `cd /path/to/your/markdown/files`

2. 在终端中查看文件状态：  
   `git status`

3. 添加文件到 Git：  
   `git add .`

4. 提交修改：  
   `git commit -m "Initial commit or your message"`

5. 初始化 Git 仓库：  
   `git init`

6. 将远程仓库与本地关联：  
     ```git remote add origin https://github.com/wuqiang0720/your-repo.git```

7. 推送到远程仓库:  

     ```shell
     git push -u origin main
     ```


  * set proxy if error occur `fatal: unable to access 'https://github.com/wuqiang0720/blogs.git/': OpenSSL SSL_read: SSL_ERROR_SYSCALL, errno 0`

    ```sh
    $ git config --global http.proxy http://xxxxxxxxx:8888
    
    $ git config --global https.proxy http://xxxxx:8888
    
    $ git config --get  https.proxy
    
    ```
    
    

