#!/bin/bash

##补充汉化       
cp -f ./feeds/00575/patch/udpxy.lua ./feeds/luci/applications/luci-app-udpxy/luasrc/model/cbi
##
echo -e "\nmsgid \"General\"" >> package/feeds/luci/luci-app-dnsforwarder/po/zh-cn/dnsforwarder.po
echo -e "msgstr \"常规\"" >> package/feeds/luci/luci-app-dnsforwarder/po/zh-cn/dnsforwarder.po

echo -e "\nmsgid \"LOG\"" >> package/feeds/luci/luci-app-dnsforwarder/po/zh-cn/dnsforwarder.po
echo -e "msgstr \"日志\"" >> package/feeds/luci/luci-app-dnsforwarder/po/zh-cn/dnsforwarder.po

              
##配置ip等
sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm-k3|TARGET_DEVICES += phicomm-k3| ; s|# TARGET_DEVICES += phicomm_k3|TARGET_DEVICES += phicomm_k3|' target/linux/bcm53xx/image/Makefile
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

sed -i '/root::0:0:99999/d' package/lean/default-settings/files/zzz-default-settings

##取消bootstrap为默认主题
#sed -i '/uci commit luci/i\uci set luci.main.mediaurlbase="/luci-static/argon"' `find package -type f -path '*/default-settings/files/*-default-settings'`
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon-18.06/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon-18.06/g' feeds/luci/collections/luci-nginx/Makefile


##加入作者信息
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='$(date +%Y%m%d)'/g" package/lean/default-settings/files/zzz-default-settings   
# sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION=' YaoDao'/g" package/lean/default-settings/files/zzz-default-settings
sed -i ‘/固件作者/d’ package/feeds/00575/patch/autocore/files/arm/index.htm
# cp -af feeds/00575/patch/banner  package/base-files/files/etc/

##add pwm fan control service
wget https://github.com/friendlyarm/friendlywrt/commit/cebdc1f94dcd6363da3a5d7e1e69fd741b8b718e.patch
git apply cebdc1f94dcd6363da3a5d7e1e69fd741b8b718e.patch
rm cebdc1f94dcd6363da3a5d7e1e69fd741b8b718e.patch
sed -i 's/pwmchip1/pwmchip0/' target/linux/rockchip/armv8/base-files/usr/bin/fa-fancontrol.sh target/linux/rockchip/armv8/base-files/usr/bin/fa-fancontrol-direct.sh

sed -i 's/START=95/START=99/' `find package/ -follow -type f -path */ddns-scripts/files/ddns.init`


##更改主机名
sed -i "s/hostname='.*'/hostname='R2S'/g" package/base-files/files/bin/config_generate


##切换为samba4
sed -i 's/luci-app-samba/luci-app-samba4/g' package/lean/autosamba/Makefile


##boos4721
sed -i 's/10.10.10.1/192.168.2.1/g' package/base-files/files/bin/config_generate
sed -i 's/$1$WplwC1t5$HBAtVXABp7XbvVjG4193B.:18753/:/g' package/base-files/files/etc/shadow
sed -i "s/encryption=.*/encryption=none/g" package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i "/key=.*/d" package/kernel/mac80211/files/lib/wifi/mac80211.sh


##FQ全部调到VPN菜单
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-ssr-plus/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/*.lua
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-ssr-plus/luasrc/view/shadowsocksr/*.htm

sed -i 's/services/vpn/g' package/feeds/00575/luci-app-passwall/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-passwall/luasrc/model/cbi/passwall/api/*.lua
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-passwall/luasrc/model/cbi/passwall/client/*.lua
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-passwall/luasrc/model/cbi/passwall/server/*.lua
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-passwall/luasrc/view/passwall/app_update/*.htm
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-passwall/luasrc/view/passwall/global/*.htm
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-passwall/luasrc/view/passwall/haproxy/*.htm
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-passwall/luasrc/view/passwall/log/*.htm
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-passwall/luasrc/view/passwall/node_list/*.htm
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-passwall/luasrc/view/passwall/rule/*.htm
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-passwall/luasrc/view/passwall/server/*.htm

sed -i 's/services/vpn/g' package/feeds/00575/luci-app-vssr/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-vssr/luasrc/model/cbi/vssr/*.lua
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-vssr/luasrc/view/vssr/*.htm

sed -i 's/services/vpn/g' package/feeds/00575/luci-app-openclash/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-openclash/luasrc/*.lua
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-openclash/luasrc/model/cbi/openclash/*.lua
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-openclash/luasrc/view/openclash/*.htm

sed -i 's/services/vpn/g' package/feeds/00575/luci-app-bypass/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-bypass/luasrc/model/cbi/bypass/*.lua
sed -i 's/services/vpn/g' package/feeds/00575/luci-app-bypass/luasrc/view/bypass/*.htm

##
sed -i '/option Interface/d'  package/network/services/dropbear/files/dropbear.config


## rockchip
cp -af feeds/00575/patch/rockchip/*  target/linux/rockchip/armv8/base-files/
