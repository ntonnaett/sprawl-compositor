#!/bin/sh

QT_QPA_EGLFS_ALWAYS_SET_MODE='1'
IM_MODULE='qtvirtualkeyboard'

cd builddir && ninja
