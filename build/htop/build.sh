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

PROG=htop
PKG=ooce/system/htop
VER=3.0.5
SUMMARY="htop"
DESC="An interactive process viewer for Unix"

set_arch 64

# need stack_t, timestruc_t, label_t, ...
set_standard XPG6

XFORM_ARGS="-DPREFIX=${PREFIX#/}"

init
download_source $PROG $VER
patch_source
prep_build "" -autoreconf
build
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
