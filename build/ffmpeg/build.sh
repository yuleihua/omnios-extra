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

# Copyright 2021 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/functions.sh

PROG=ffmpeg
VER=4.4
PKG=ooce/multimedia/ffmpeg
SUMMARY="ffmpeg"
DESC="A complete, cross-platform solution to record, "
DESC+="convert and stream audio and video."

OPREFIX=$PREFIX
PREFIX+="/$PROG"

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DOPREFIX=${OPREFIX#/}
    -DPROG=$PROG
    -DPKGROOT=$PROG
"

# ffmpeg contains BMI instructions even when built on an older CPU
BMI_EXPECTED=1

CONFIGURE_OPTS="
    --prefix=$PREFIX
    --incdir=$OPREFIX/include
    --disable-static
    --enable-shared
    --disable-debug
    --disable-stripping
    --enable-libfontconfig
    --enable-libfreetype
    --enable-libvorbis
    --enable-libwebp
    --enable-gpl
    --enable-libx264
    --enable-libx265
    --enable-gnutls
"
[ $RELVER -ge 151036 ] && CONFIGURE_OPTS+=" --enable-libdav1d"
CONFIGURE_OPTS_32="
    --libdir=$OPREFIX/lib
"
CONFIGURE_OPTS_64="
    --libdir=$OPREFIX/lib/$ISAPART64
"

# to find x264.h for builtin check
CPPFLAGS+=" -I$OPREFIX/include"
LDFLAGS32+=" -R$OPREFIX/lib"
LDFLAGS64+=" -R$OPREFIX/lib/$ISAPART64"

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
strip_install
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
