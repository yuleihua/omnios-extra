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

PROG=flac
VER=1.3.3
PKG=ooce/audio/flac
SUMMARY="flac"
DESC="Free Lossless Audio Codec"

forgo_isaexec

OPREFIX=$PREFIX
PREFIX+="/$PROG"

BUILD_DEPENDS_IPS="
    developer/nasm
    ooce/library/libogg
"

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DOPREFIX=${OPREFIX#/}
    -DPROG=$PROG
    -DPKGROOT=$PROG
"

CONFIGURE_OPTS="
    --prefix=$PREFIX
    --includedir=$OPREFIX/include
"
CONFIGURE_OPTS_32="
    --libdir=$OPREFIX/lib
"
CONFIGURE_OPTS_64="
    --libdir=$OPREFIX/lib/$ISAPART64
    --build=$TRIPLET64
"

CFLAGS+=" -I$OPREFIX/include"
LDFLAGS32+=" -L$OPREFIX/lib -R$OPREFIX/lib"
LDFLAGS64+=" -L$OPREFIX/lib/$ISAPART64 -R$OPREFIX/lib/$ISAPART64"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
