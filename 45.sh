#!/bin/bash

# 清空控制台
clear
echo "少女为你祈祷中..."

# 检测当前目录是否为Miao-Yunzai
if [[ $(basename "$PWD") == "Miao-Yunzai" ]]; then
    echo "当前目录是 Miao-Yunzai"

    # 检测是否存在 node_modules 文件夹
    if [[ -d "./node_modules" ]]; then
        # 删除目标文件
        if [[ -f "./node_modules/icqq/lib/core/device.js" ]]; then
            rm -f ./node_modules/icqq/lib/core/device.js
        fi
        
        echo "少女正在下载版本文件"
        # 下载新的 device.js
        curl -o ./node_modules/icqq/lib/core/device.js https://fujiang.icu:20457/down/ap9v6CIKYOKD.js

        if [[ $? -eq 0 ]]; then
            echo "下载成功"
        else
            echo "下载失败"
            exit 1
        fi
    else
        echo "未检测到 node_modules 文件夹"
        exit 1
    fi

    # 检测并复制 bot.yaml
    if [[ ! -f "./config/config/bot.yaml" ]]; then
        echo "检测到没有 bot.yaml"
        cp ./config/default_config/bot.yaml ./config/config/bot.yaml
    else
        echo "检测到有 bot.yaml"
    fi

    # 修改 bot.yaml
    echo "正在修改 bot.yaml"
    sed -i "s|log_level:.*|log_level: info|g" ./config/config/bot.yaml
    sed -i "s|ignore_self:.*|ignore_self: true|g" ./config/config/bot.yaml
    sed -i "s|resend:.*|resend: false|g" ./config/config/bot.yaml
    sed -i "s|sendmsg_error:.*|sendmsg_error: false|g" ./config/config/bot.yaml
    sed -i "s|restart_port:.*|restart_port: 27881|g" ./config/config/bot.yaml
    sed -i "s|sign_api_addr:.*|sign_api_addr: https://hlhs-nb.cn/signed/?key=114514\&ver=9.0.70|g" ./config/config/bot.yaml

    echo "签名修改成功..."
else
    echo "当前目录不是 Miao-Yunzai，请在 Miao-Yunzai 目录下运行此脚本。"
    exit 1
fi
