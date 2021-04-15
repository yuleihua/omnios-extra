#!/usr/bin/bash
#
# {{{ CDDL HEADER
#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source. A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
# }}}

# Copyright 2020 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/functions.sh

PROG=ldns
VER=1.7.1
PKG=ooce/library/ldns
SUMMARY=$PROG
DESC="$PROG DNS programming library and drill utility"

OPREFIX=$PREFIX
PREFIX+="/$PROG"

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DOPREFIX=${OPREFIX#/}
    -DPKGROOT=$PROG
"

CONFIGURE_OPTS="
    --prefix=$PREFIX
    --disable-static
    --disable-dane-ta-usage
"
CONFIGURE_OPTS_32+="
    --bindir=$PREFIX/bin/$ISAPART
"
CONFIGURE_OPTS_64+="
    --bindir=$PREFIX/bin
    --with-drill
    --with-examples
"

# The 'distclean' target clobbers too much including 'configure'
make_clean() {
    logcmd $MAKE clean
}

make_isa_stub() {
    pushd $DESTDIR$PREFIX/bin >/dev/null
    logcmd mkdir -p $ISAPART64
    logcmd mv ldns-config $ISAPART64/ || logerr "mv ldns-config"
    make_isaexec_stub_arch $ISAPART64 $PREFIX/bin
    popd >/dev/null
}

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_isa_stub
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
