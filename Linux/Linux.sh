#!/bin/bash
sudo mv /etc/hosts /etc/hosts.bak
wget http://hostsx.googlecode.com/svn/trunk/HostsX.orzhosts
sudo mv hosts /etc/hosts
sudo gedit /etc/hosts
sudo /etc/init.d/networking restart