### 登录信息：
登录IP：192.168.2.1 

默认用户名：root 

密码：password

### 固件特性：

slim版固件只有OpenWrt本体，但内置了“本地软件源”，包含大部分常用插件，不喜欢固件预装繁杂插件的人可以选择这个版本，进入后台软件包选装所需插件

采用ext4文件系统，刷卡之后可自行使用分区工具对sd卡扩容根分区至最大。使用在线升级时，根分区会自动扩容，方便折腾

### 终端内在线升级方法： 

5.4.x内核 slim纯净版
```bash
wget -qO- https://github.com/00575/R2S/raw/master/scripts/autoupdate.sh | ver=-slim sh
```

5.10.x内核 slim纯净版
```bash
wget -qO- https://github.com/00575/R2S/raw/master/scripts/5.10.x.sh | ver=-slim sh
```

临时测试
```bash
wget -qO- https://github.com/00575/R2S/raw/master/scripts/Test-update.sh | sh
```
```bash
wget -qO- https://github.com/00575/R2S/raw/master/scripts/Test-5.10.x.sh | sh
```
