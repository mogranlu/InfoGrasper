#!/bin/bash

## Set good error handling (exit on error and unset variables)
echo "INFO: Entering script $0"
set -o errexit
set -o nounset

## 
if [ "root" == "$(whoami)" ]
then
   echo "ERROR! You cannot be logged in as root!"
   exit 1
fi

## Create git dir, if it does not already exist
githome="~/git"
[ -d "$githome" ] || mkdir "$githome"

## Load latest version of application from git repo
cd $githome
git --git-dir=$githome clone $gitURL

## Read properties from infograsper.properties
. ~/git/InfoGrasper/scripts/infograsper.properties

## Add some extra aliases
echo -n ". $githome/InfoGrasper/scripts/my_aliases" >> ~/.bashrc

## Set correct locale on keyboard (input map)
localectl set-keymap no106
localectl set-x11-keymap no

## Update and upgrade OS to latest version
sudo apt-get update
sudo apt-get upgrade

sudo echo -n ${myhostname} > /etc/hostname

## Some of the changes need a reboot (keyboard input map and hostname)
#sudo shutdown -r 'now'
sudo shutdown -r 

