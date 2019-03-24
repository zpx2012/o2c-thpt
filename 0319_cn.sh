#!/bin/bash
cd ~/o2c-thpt/
node_i=$1
mtr=mtr-insertion/mtr
for day_i in 0 1 2 3; do
    dfile=data/node${node_i}_day${day_i}.csv
    cat $dfile | while IFS=' ' read ip hn dp sp; do
        screen -dmS td_$hn bash tcpdump_whole.sh $ip $dp $hn c
        screen -dmS curl_$hn python curl_downloader.py "http://$ip/my.pcap" $ip $hn 0 750k 0 $sp
    done
    screen -dmS mtr bash mtr_poll_check.sh $dfile $mtr
    sleep 86400
    bash ks.sh mtr
    bash ks.sh td
    bash ks.sh curl
done