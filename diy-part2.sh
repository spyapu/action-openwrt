#!/bin/bash
#
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.21.1/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# Set default LuCI language to Chinese
LUCI_CONF="feeds/luci/modules/luci-base/root/etc/config/luci"
if [ -f "$LUCI_CONF" ]; then
    sed -i 's/option lang auto/option lang zh_cn/g' "$LUCI_CONF"
else
    mkdir -p "$(dirname "$LUCI_CONF")"
    printf 'config core main\n\toption lang zh_cn\n' > "$LUCI_CONF"
fi

# Ensure Chinese language packages are included (re-appended after any defconfig pre-processing)
grep -q '^CONFIG_LUCI_LANG_zh_cn=y' .config || echo 'CONFIG_LUCI_LANG_zh_cn=y' >> .config
grep -q '^CONFIG_PACKAGE_luci-i18n-base-zh-cn=y' .config || echo 'CONFIG_PACKAGE_luci-i18n-base-zh-cn=y' >> .config