#!/bin/bash
if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit 1
fi
node_i=$1
today=$2
st_in=$3
st_out=`date --date="$st_in" -u +"%m%d%H%M"`
st_sec=`date --date="$st_in" +"%s"`
mtr=~/o2c-thpt/mtr-insertion/mtr

cd ~/o2c-thpt/o2c
dfile=node${node_i}_day${today}.csv
cat $dfile | while IFS=' ' read ip hn dp sp; do
    screen -dmS td_$hn bash ~/o2c-thpt/tcpdump_whole.sh $ip $dp $hn c
    screen -dmS curl_$hn python ~/o2c-thpt/curl_downloader_resume.py "http://$ip/my.pcap" $ip $hn 0 750k 0 $sp ${st_out}utc
done
screen -dmS mtr bash ~/o2c-thpt/mtr_poll_check_resume.sh $dfile $mtr $st_out
now=`date -u +"%s"`
sleep $((86400 - now + st_sec))
bash ~/o2c-thpt/ks.sh mtr
bash ~/o2c-thpt/ks.sh td
bash ~/o2c-thpt/ks.sh curl

for ((day_i=today+1; day_i<4; day_i++)); do
    dfile=node${node_i}_day${day_i}.csv
    cat $dfile | while IFS=' ' read ip hn dp sp; do
        screen -dmS td_$hn bash ~/o2c-thpt/tcpdump_whole.sh $ip $dp $hn c
        screen -dmS curl_$hn python ~/o2c-thpt/curl_downloader.py "http://$ip/my.pcap" $ip $hn 0 750k 0 $sp
    done
    screen -dmS mtr bash ~/o2c-thpt/mtr_poll_check.sh $dfile $mtr
    sleep 86400
    bash ~/o2c-thpt/ks.sh mtr
    bash ~/o2c-thpt/ks.sh td
    bash ~/o2c-thpt/ks.sh curl
done