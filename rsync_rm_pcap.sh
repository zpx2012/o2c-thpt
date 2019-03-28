#!/bin/bash
cd ~/o2c-thpt
chmod 400 tmp_rsa
outd=/data/tmp/st-data/$(hostname)
ssh -oStrictHostKeyChecking=no -i tmp_rsa tmp@terran.cs.ucr.edu mkdir -p $outd
while true; do
    rsync -avzS --remove-source-files --progress --rsh='ssh -oStrictHostKeyChecking=no -i tmp_rsa' rs/tcpdump_* tmp@terran.cs.ucr.edu:$outd/
    sleep 3600
done