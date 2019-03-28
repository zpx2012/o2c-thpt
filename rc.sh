#!/bin/bash
if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit 1
fi
screen -dmS o2c bash ~/o2c-thpt/0319_cn.sh $1