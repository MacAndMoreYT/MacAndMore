#!/bin/bash
# ------------------------------------------------------------------
# [Nick Hildebrandt] MacAndMore
#          (C)2020
# ------------------------------------------------------------------

apt update -y
apt install sudo curl gnupg2 software-properties-common -y
sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list << EOF
deb https://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main
EOF

sudo tee /etc/apt/sources.list.d/pritunl.list << EOF
deb https://repo.pritunl.com/stable/apt buster main
EOF

sudo apt-get install dirmngr
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv E162F504A20CDF15827F718D4B7C549A058F8B6B
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
sudo apt-get update
sudo apt-get --assume-yes install pritunl mongodb-org
sudo systemctl start mongod pritunl
sudo systemctl enable mongod pritunl
clear
echo 'Reboot? (Empfohlen)(y/n)' && read x && [[ "$x" == "y" ]] && /sbin/reboot
done
