### R2S lean稳定版 固件发布地址：
https://github.com/00575/nanopi-R2S/releases

登录IP：192.168.2.1  默认用户名：root  密码：password

##### 终端内升级方法:  
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


### Nanopi-openwrt固件发布地址： 
(r1s r2s r4s r1p r1s-h3 x86)

https://github.com/00575/Nanopi/releases



++++++++++++++++++++++++++++++++++++++++++++++++++++++++


##### 临时测试 升级#####
r2s-18.06
```bash
wget -qO- https://github.com/00575/nanopi/raw/master/scripts/update.sh | sh
```
