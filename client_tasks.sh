#!/bin/bash

#Pull asset tag from UEFI of Dell Wyse 3040, set hostname and create wallpaper
#Requires imagemagick and dmidecode

cbg='black'
ct='white'
r='1920x1080'
f='helvetica'
u='ltsp'

#Retrieve Asset Tag
asset_tag=$(dmidecode -t 3 | grep 'Asset Tag:' | sed 's/	Asset Tag: //g')

#Create Wallpaper
rm wallpaper.png
convert -size $r xc:$cbg temp.png
convert -font $f -fill $ct -pointsize 120 -gravity center -draw "text 0,0 '$asset_tag'" temp.png wallpaper.png
rm temp.png

#Move wallpaper to user home
mv wallpaper.png /home/$u/
chown $u:$u /home/$u/wallpaper.png

#Set hostname
sysctl -w kernel.hostname=$asset_tag
hostnamectl hostname $asset_tag
rm /etc/hostname
touch /etc/hostname
echo $asset_tag | cat > /etc/hostname
