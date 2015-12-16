#!/bin/bash

## Set good error handling (exit on error and unset variables)
echo "INFO: Entering script $0"
set -o errexit
set -o nounset

## Do not allow script to be run as root
if [[ "$EUID" -eq 0 ]]; then
   echo "ERROR! You cannot be logged in as root!"
   exit 1
fi

## Create git dir, if it does not already exist
## NB! Cannot get the "magic" ~ to work as a user home substitute, so hardcoding the path to the "pi" user:
githome="/home/pi/git"
[ -d "$githome" ] || mkdir $githome

## Load latest version of application from git repo
cd $githome
git --git-dir=$githome clone https://github.com/mogranlu/InfoGrasper.git

## Add some extra aliases
echo -n ". $githome/InfoGrasper/scripts/my_aliases" >> ~/.bashrc

## Set correct locale on keyboard (input map)
sudo localectl set-keymap no106
sudo localectl set-x11-keymap no

## Update and upgrade OS to latest version
sudo apt-get update
sudo apt-get upgrade

sudo sh -c 'echo "infoskjerm1" > /etc/hostname'

## Some of the changes need a reboot (keyboard input map and hostname)
#sudo shutdown -r 'now'
sudo shutdown -r 

