if [ -z "$1" ]
  then
    echo "No argument supplied"
fi
sudo apt-get update
sudo apt-get install -y git
cd ~
git clone --recurse-submodules https://github.com/zpx2012/o2c-thpt.git
cd o2c-thpt
bash install.sh
screen -dmS o2c bash 0319_cn.sh $1
screen -dmS rsync bash rsync.sh