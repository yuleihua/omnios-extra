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
#
# Copyright 2021 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/functions.sh

PKG=ooce/multimedia/exif
VER=0.6.21
PROG=exif
POPTVER=1.14
SUMMARY="Exif utility"
DESC="A small command-line utility to show EXIF information hidden in "
DESC+="JPEG files"

BUILD_DEPENDS_IPS=ooce/library/libexif

OPREFIX=$PREFIX
PREFIX+="/$PROG"

set_arch 64

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DOPREFIX=${OPREFIX#/}
    -DPROG=$PROG
    -DPKGROOT=$PROG
"

init
prep_build

#########################################################################
# Download and build a static version of popt

save_buildenv

CONFIGURE_OPTS=" --disable-shared --enable-static"

build_dependency popt popt-$POPTVER popt popt $POPTVER

restore_buildenv

export POPT_CFLAGS="-I$DEPROOT/$PREFIX/include"
export POPT_LIBS="-L$DEPROOT/$PREFIX/lib/$ISAPART64 -lpopt"

#########################################################################

export LIBEXIF_CFLAGS="-I$OPREFIX/include"
export LIBEXIF_LIBS="-L$OPREFIX/lib/$ISAPART64 -R$OPREFIX/lib/$ISAPART64 -lexif"

download_source $PROG $PROG $VER
patch_source
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
