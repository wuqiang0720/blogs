- #### 运行如下命令
```bash
yum install -y bash-completion
locate bash_completion
source /usr/share/bash-completion/bash_completion
source <(kubectl completion bash)
```

- #### 永久生效将下面命令放入开机执行脚本里（.bashrc）

```
 source /usr/share/bash-completion/bash_completion
 source <(kubectl completion bash)
```
