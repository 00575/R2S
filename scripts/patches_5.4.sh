config_file_turboacc=`find package/ -follow -type f -path '*/luci-app-turboacc/root/etc/config/turboacc'`
sed -i "s/option hw_flow '1'/option hw_flow '0'/" $config_file_turboacc
sed -i "s/option sfe_flow '1'/option sfe_flow '0'/" $config_file_turboacc
sed -i "s/option sfe_bridge '1'/option sfe_bridge '0'/" $config_file_turboacc
sed -i "/dep.*INCLUDE_.*=n/d" `find package/ -follow -type f -path '*/luci-app-turboacc/Makefile'`

sed -i "s/option limit_enable '1'/option limit_enable '0'/" `find package/ -follow -type f -path '*/nft-qos/files/nft-qos.config'`
sed -i "s/option enabled '1'/option enabled '0'/" `find package/ -follow -type f -path '*/vsftpd-alt/files/vsftpd.uci'`
sed -i "/\/etc\/coremark\.sh/d" `find package/ -follow -type f -path '*/coremark/coremark'`
sed -i 's/192.168.1.1/192.168.2.1/' package/base-files/files/bin/config_generate
sed -i '/root::0:0:99999/d' package/lean/default-settings/files/zzz-default-settings
sed -i 's/=1/=0/g' package/kernel/linux/files/sysctl-br-netfilter.conf

sed -i '/DEPENDS+/ s/$/ +wsdd2/' `find package/ -follow -type f -path '*/ksmbd-tools/Makefile'`

sed -i 's/ +ntfs-3g/ +ntfs3-mount/' `find package/ -follow -type f -path '*/automount/Makefile'`
sed -i '/skip\=/ a skip=`mount | grep -q /dev/$device; echo $?`' `find package/ -follow -type f -path */automount/files/15-automount`

sed -i 's/START=95/START=99/' `find package/ -follow -type f -path */ddns-scripts/files/ddns.init`

mkdir -p `find package/ -follow -type d -path '*/pdnsd-alt'`/patches
mv $GITHUB_WORKSPACE/patches/99-disallow-aaaa.patch `find package/ -follow -type d -path '*/pdnsd-alt'`/patches

sed -i 's/5.0/1.0/' .ccache/ccache.conf || true

line_number_INCLUDE_Xray=$[`grep -m1 -n 'Include Xray' package/custom/openwrt-passwall/luci-app-passwall/Makefile|cut -d: -f1`-1]
sed -i $line_number_INCLUDE_Xray'd' package/custom/openwrt-passwall/luci-app-passwall/Makefile
sed -i $line_number_INCLUDE_Xray'd' package/custom/openwrt-passwall/luci-app-passwall/Makefile
sed -i $line_number_INCLUDE_Xray'd' package/custom/openwrt-passwall/luci-app-passwall/Makefile
line_number_INCLUDE_V2ray=$[`grep -m1 -n 'Include V2ray' package/custom/openwrt-passwall/luci-app-passwall/Makefile|cut -d: -f1`-1]
sed -i $line_number_INCLUDE_V2ray'd' package/custom/openwrt-passwall/luci-app-passwall/Makefile
sed -i $line_number_INCLUDE_V2ray'd' package/custom/openwrt-passwall/luci-app-passwall/Makefile
sed -i $line_number_INCLUDE_V2ray'd' package/custom/openwrt-passwall/luci-app-passwall/Makefile


if [[ $BRANCH == 'master' ]]; then

  # fix po path for snapshot
  #find package/ -follow -type d -path '*/po/zh-cn' | xargs dirname | xargs -n1 -i sh -c "rm -f {}/zh_Hans; ln -sf zh-cn {}/zh_Hans"

  # enable r2s oled plugin by default
  sed -i "s/enable '0'/enable '1'/" `find package/ -follow -type f -path '*/luci-app-oled/root/etc/config/oled'`

  case $DEVICE in
    r2s|r2c|r1p|r1p-lts)
      # change the voltage value for over-clock stablization
      config_file_cpufreq=`find package/ -follow -type f -path '*/luci-app-cpufreq/root/etc/config/cpufreq'`
      truncate -s-1 $config_file_cpufreq
      echo -e "\toption governor0 'schedutil'" >> $config_file_cpufreq
      echo -e "\toption minfreq0 '816000'" >> $config_file_cpufreq
      echo -e "\toption maxfreq0 '1512000'\n" >> $config_file_cpufreq

      # add pwm fan control service
      wget https://github.com/friendlyarm/friendlywrt/commit/cebdc1f94dcd6363da3a5d7e1e69fd741b8b718e.patch
      git apply cebdc1f94dcd6363da3a5d7e1e69fd741b8b718e.patch
      rm cebdc1f94dcd6363da3a5d7e1e69fd741b8b718e.patch
      sed -i 's/pwmchip1/pwmchip0/' target/linux/rockchip/armv8/base-files/usr/bin/fa-fancontrol.sh target/linux/rockchip/armv8/base-files/usr/bin/fa-fancontrol-direct.sh
      ;;
  esac

fi

# inject the firmware version
strDate=`TZ=UTC-8 date +%Y-%m-%d`
status_pages=`find package/ -follow -type f \( -path '*/autocore/files/arm/index.htm' -o -path '*/autocore/files/x86/index.htm' -o -path '*/autocore/files/arm/rpcd_10_system.js' -o -path '*/autocore/files/x86/rpcd_10_system.js' \)`
for status_page in $status_pages; do
case $status_page in
  *htm)
    line_number_FV=`grep -n 'Firmware Version' $status_page | cut -d: -f 1`
    sed -i '/ver\./d' $status_page
    sed -i $line_number_FV' a <a href="https://github.com/00575/Nanopi" target="_blank">00575/Nanopi</a> '$strDate $status_page
    ;;
  *js)
    line_number_FV=`grep -m1 -n 'var fields' $status_page | cut -d: -f1`
    sed -i $line_number_FV' i var pfv = document.createElement('\''placeholder'\'');pfv.innerHTML = '\''<a href="https://github.com/00575/Nanopi" target="_blank">00575/Nanopi</a> '$strDate"';" $status_page
    line_number_FV=`grep -n 'Firmware Version' $status_page | cut -d : -f 1`
    sed -i '/Firmware Version/d' $status_page
    sed -i $line_number_FV' a _('\''Firmware Version'\''), pfv,' $status_page
    ;;
esac
done

# set default theme to argon
sed -i '/uci commit luci/i\uci set luci.main.mediaurlbase="/luci-static/argon"' `find package -type f -path '*/default-settings/files/*-default-settings'`

# 设置内核为5-4
sed -i "s/KERNEL_PATCHVER:=*.*/KERNEL_PATCHVER:=5.4/g" target/linux/rockchip/Makefile
sed -i "s/KERNEL_PATCHVER=*.*/KERNEL_PATCHVER=5.4/g" target/linux/rockchip/Makefile        
