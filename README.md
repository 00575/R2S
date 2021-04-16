### 固件发布地址：
https://github.com/00575/nanopi-R2S/releases

登录IP：192.168.2.1

默认用户名：root

密码：password

### R2S精简固件 在线升级方法:  
先安装好依赖
```bash
opkg update
opkg install zstd
opkg install libzstd
```
然后下载脚本执行
```bash
wget -qO- https://github.com/00575/nanopi-R2S/raw/master/scripts/autoupdate.sh | sh
```

++++++++++++++++++++++++++++++++++++++++++++++++++++++++


### R2S-immortalwrt-固件 终端内在线升级方法： 


多插件版

```bash
wget -qO- https://github.com/a0575/R2S/raw/master/scripts/update.sh | sh
```

纯净版

```bash
wget -qO- https://github.com/a0575/R2S/raw/master/scripts/update.sh | ver=-slim sh
```

自用版

```bash
wget -qO- https://github.com/00575/nanopi-R2S/raw/master/scripts/update.sh | sh
```

