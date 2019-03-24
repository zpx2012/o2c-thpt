#!/bin/bash
cd ~/o2c-thpt/
mtr=mtr-insertion/mtr
for day_i in 0 1 2 3; do
    dfile=data/$(hostname)_$(date -u +"%m%d").csv
    cat $dfile | while IFS=' ' read ip hn dp sp; do
        screen -dmS td_$hn bash tcpdump_whole.sh $ip $sp $hn s
    done
    screen -dmS mtr bash mtr_poll_check.sh $dfile $mtr
    sleep 86400
    bash ks.sh mtr
    bash ks.sh td
done