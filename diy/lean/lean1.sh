#!/bin/bash

##添加自己的插件库
rm -rf ./package/lean/k3screenctrl
rm -rf ./package/lean/autocore
               
sed -i "1isrc-git 00575 https://github.com/00575/openwrt-packages" feeds.conf.default
sed -i "2isrc-git ipkg https://github.com/xiangfeidexiaohuo/op-ipkg\n" feeds.conf.default
