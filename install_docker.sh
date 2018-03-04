#!/bin/bash

# run this ON the raspberry 
# should run as root: sudo ./install.sh 




########### check for sudo 
# ref: https://askubuntu.com/a/30157/8698
if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi
# $SUDO_USER is set if using sudo ./this-script.sh 
if [ $SUDO_USER ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
fi
# use this in front of non-sudo lines: 
# sudo -u $real_user ... 
########## 

# get docker for arm6
#curl -sSL https://get.docker.com | sh 
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh

# add Docker to auto-start 
# sudo 
#systemctl enable docker 

# start daemon (or reboot)
# sudo 
systemctl start docker 

# add user to the docker group to be able to run docker client  
# sudo 
usermod -aG docker $real_user 
