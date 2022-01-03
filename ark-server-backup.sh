#!/bin/bash

## Announce restart and save
##/usr/bin/screen -S ark -X stuff "say Restarting...^M"
##/usr/bin/screen -S ark -X stuff "save^M"
##sleep 10

##Stop server
sudo systemctl stop ark
sleep 10

##Backup to temp directory on SSD
Name=server-$(date +%F-%H-%M).tar.gz
tar -cvpzf /opt/ark/temp/$Name /opt/ark/server/ShooterGame/Saved

##Download latest version and extract
steamcmd +force_install_dir /opt/ark/server +login anonymous +app_update 376030 -validate +exit
sleep 10

##Start server
sudo systemctl start ark

## Transfer backup to backup HDD
mv /opt/ark/temp/$Name /opt/ark/backups

## Delete older backups
find /opt/ark/backups/ -type f -mtime +7 ! -name "*$(date +%Y-%m-01)*.gz" -delete
