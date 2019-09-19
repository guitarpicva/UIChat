#!/bin/bash
################################################################################
# File Name : install
# Author : Mitch Winkle, AB4MW
# Version : 1.07
# Date : 28 July 2015
# License : Gnu GPL v3.0
# Description : README for the UIChat program
################################################################################
# This file is part of UIChat.
# Copyright 2015 Mitch Winkle
#
#   UIChat is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   UIChat is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with UIChat (COPYING text file). If not, see <http://www.gnu.org/licenses/>.
################################################################################
if [[ $UID != "0" ]]; then
	echo -e "You must be root to install this program.\n\nTry sudo ./install"
	exit 1
fi
echo " This install script installs a new UIChat system or upgrades an existing" 
echo " installation of UIChat."
echo ""
echo " Existing /etc/uichatd.conf, heard file and any msg files will"
echo " not be disturbed."
echo ""
echo "Press Y to continue with the installation.  Any other key to exit."
echo ""
read answer
case $answer in
	[yY]);;
	*) echo "No changes have been made to your system...exiting."
	exit 0;
	;;
esac
echo ""
if [[ ! -f /var/ax25/uichatd/heard ]]; then
	mkdir -p /var/ax25/uichatd
	touch /var/ax25/uichatd/heard
	chmod 644 /var/ax25/uichatd/heard
else
	echo "The /var/ax25/uichatd/heard file was not disturbed."
fi
mkdir -p /etc/uichatd
cp uichatd.template /etc/uichatd
chmod 644 /etc/uichatd/uichatd.template
if [[ -f /etc/uichatd/uichatd.conf ]]; then
	echo "Existing uichatd.conf file has not been disturbed."
	echo "Compare with /etc/uichatd/uichatd.template for any new parameters."
else
	cp uichatd.conf /etc/uichatd/uichatd.conf
	chmod 644 /etc/uichatd/uichatd.conf
fi
if [[ -f /etc/uichatd/uichatd.rigctl ]]; then
	echo "Existing uichatd.rigctl file has not been disturbed."
	echo "Compare with ./uichatd.rigctl for any new parameters."
else
	cp uichatd.rigctl /etc/uichatd/uichatd.rigctl
fi
#remove version indicator from the config file.
sed -i '/^VER=/d' /etc/uichatd/uichatd.conf
mkdir -p /usr/share/doc/uichatd
cp README.txt /usr/share/doc/uichatd
cp COPYING /usr/share/doc/uichatd
cp UIChat_Syntax.pdf /usr/share/doc/uichatd
chmod 644 /usr/share/doc/uichatd/*
cp uichat /usr/local/bin
cp uichatd /usr/local/bin
chmod 755 /usr/local/bin/uichat
chmod 755 /usr/local/bin/uichatd
exit 0
