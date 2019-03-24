#!/bin/bash
cd ~/o2c-thpt
chmod 400 tmp_rsa
outd=/data/tmp/st-data/$(hostname)
ssh -oStrictHostKeyChecking=no -i tmp_rsa tmp@terran.cs.ucr.edu mkdir -p $outd
while true; do
    rsync -avzS --progress --remove-source-files rs/* tmp@terran.cs.ucr.edu:$outd/
    sleep 600
done