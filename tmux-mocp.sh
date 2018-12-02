#!/bin/bash

# ----------------CopyRight----------------
# Name:             
# Version:          
# Type:             
# Language:         bash shell
# Date:             
# Author:           Ewen Lai
# E-mail:           lwwen1107@qq.com
# ---------------Environment---------------
# Ubuntu 16.04
# GNU Bash
# -----------------------------------------

type mocp > /dev/null 2>&1 || exit 1
mocp -Q %state > /dev/null 2>&1
if [ $? = 0 ]; then
    musicpath=`mocp -Q %file`
    musicfile=${musicpath##*/}
    musicname=${musicfile%.*}
    if [ `mocp -Q %state` = 'PLAY' ]; then
        flag='♫';
    else
        flag='||';
    fi
    echo ${flag} ${musicname};
fi
