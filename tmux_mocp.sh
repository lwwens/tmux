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

# 判断mocp是否安装
type mocp > /dev/null 2>&1 || exit 1
# 判断mocp是否运行，若否，则shell返回码不为0
mocp -Q %state > /dev/null 2>&1
if [ $? = 0 ]; then
    # 获得mocp正在播放的文件路径
    musicpath=`mocp -Q %file`
    # 获得带有后缀的文件名
    musicfile=${musicpath##*/}
    # 去掉文件后缀
    musicname=${musicfile%.*}
    # 判断mocp是否正在播放
    if [ `mocp -Q %state` = 'PLAY' ]; then
        flag='♫';
    else
        flag='||';
    fi
    # 返回mocp播放状态和歌曲名
    echo ${flag} ${musicname};
fi
