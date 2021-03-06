TERMUX_PKG_HOMEPAGE=https://www.wireguard.com
TERMUX_PKG_DESCRIPTION="Tools for the WireGuard secure network tunnel"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=1.0.20200121
TERMUX_PKG_SRCURL=https://git.zx2c4.com/wireguard-tools/snapshot/wireguard-tools-$TERMUX_PKG_VERSION.zip
TERMUX_PKG_SHA256=b714a51354fa8cecf4377424ea6cc9bdd07132bffc1fffe364753bf16fdb3c7f
TERMUX_PKG_DEPENDS="libmnl, tsu"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_MAKE_ARGS=" -C src WITH_BASHCOMPLETION=yes WITH_WGQUICK=no WITH_SYSTEMDUNITS=no"

termux_step_post_make_install() {
    cd src/wg-quick
    $CC $CFLAGS $LDFLAGS -DWG_CONFIG_SEARCH_PATHS="\"$TERMUX_ANDROID_HOME/.wireguard $TERMUX_PREFIX/etc/wireguard /data/misc/wireguard /data/data/com.wireguard.android/files\"" -o wg-quick android.c
    install -Dm0700 wg-quick $TERMUX_PREFIX/bin/wg-quick
}
