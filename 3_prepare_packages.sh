./scripts/feeds update -a && ./scripts/feeds install -a
rm -rf feeds/packages/libs/libcap/ && svn co https://github.com/openwrt/openwrt/trunk/package/libs/libcap feeds/packages/libs/libcap
rm -rf feeds/packages/lang/golang/ && svn co https://github.com/coolsnowwolf/packages/trunk/lang/golang feeds/packages/lang/golang
sed -i '/enable-jsonc/i\\t--disable-cloud \\' feeds/packages/admin/netdata/Makefile

# fix docker build with golang
rm -rf feeds/packages/utils/containerd && svn export https://github.com/coolsnowwolf/packages/trunk/utils/containerd feeds/packages/utils/containerd
rm -rf feeds/packages/utils/docker-ce && svn export https://github.com/coolsnowwolf/packages/trunk/utils/docker-ce feeds/packages/utils/docker-ce
rm -rf feeds/packages/utils/libnetwork && svn export https://github.com/coolsnowwolf/packages/trunk/utils/libnetwork feeds/packages/utils/libnetwork
rm -rf feeds/packages/utils/runc && svn export https://github.com/coolsnowwolf/packages/trunk/utils/runc feeds/packages/utils/runc

cd package/lean/
if [[ `pwd` == *"rk3328"* ]]; then
  rm -rf luci-app-oled/ && git clone https://github.com/NateLol/luci-app-oled
fi
[ ! -d luci-app-adguardhome ] && git clone https://github.com/rufengsuixing/luci-app-adguardhome
[ ! -d luci-app-mentohust ] && git clone https://github.com/BoringCat/luci-app-mentohust
[ ! -d mentohust ] && svn export https://github.com/immortalwrt/packages/trunk/net/mentohust
[ ! -d luci-app-jd-dailybonus ] && git clone https://github.com/jerrykuku/luci-app-jd-dailybonus
rm -rf luci-theme-argon*/ ../lean/luci-theme-argon/ && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon
rm -rf luci-theme-edge/ && git clone -b 18.06 https://github.com/garypang13/luci-theme-edge
rm -rf luci-theme-infinityfreedom/ && git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom
rm -rf luci-app-chinadns-ng/ && git clone https://github.com/WuSiYu/luci-app-chinadns-ng
rm -rf openwrt-chinadns-ng/ && git clone https://github.com/pexcn/openwrt-chinadns-ng && sed -i 's/\$(PKG_BUILD_DIR)\/chinadns-ng-update-list\.sh/files\/chinadns-ng-update-list\.sh/g' openwrt-chinadns-ng/Makefile
rm -rf v2ray/ && svn co https://github.com/immortalwrt/immortalwrt/tree/openwrt-18.06/package/lean/v2ray
#rm -rf v2ray-plugin/ && svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/v2ray-plugin
rm -rf trojan/ && svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/trojan
rm -rf autocore/ && svn export https://github.com/coolsnowwolf/lede/trunk/package/lean/autocore
svn co https://github.com/songchenwen/nanopi-r2s/trunk/luci-app-r2sflasher
sed -i "s/option limit_enable '1'/option limit_enable '0'/" nft-qos/files/nft-qos.config
cd ../../


#git clone https://github.com/jerrykuku/lua-maxminddb.git
#git clone https://github.com/jerrykuku/luci-app-vssr.git
#cd luci-app-vssr/root/etc/
#echo 'china_ssr.txt
#config/black.list
#config/white.list
#dnsmasq.oversea/oversea_list.conf
#dnsmasq.ssr/ad.conf
#dnsmasq.ssr/gfw_base.conf
#dnsmasq.ssr/gfw_list.conf' | xargs rm
#cd ../../../
