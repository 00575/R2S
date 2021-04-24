### R2S lean稳定版 固件发布地址：
https://github.com/00575/nanopi-R2S/releases

登录IP：192.168.2.1  默认用户名：root  密码：password

#####终端内升级方法:  
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


### R2S-immortalwrt-固件： 

https://github.com/a0575/R2S/releases

### R4S-immortalwrt-固件： 

https://github.com/a0575/R4S/releases


++++++++++++++++++++++++++++++++++++++++++++++++++++++++


##### 以下为个人自用

```bash
wget -qO- https://github.com/00575/nanopi-R2S/raw/master/scripts/update.sh | sh
```

