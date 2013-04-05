#!/bin/bash
sudo mv /etc/hosts /etc/hosts.bak
wget http://hostsx.googlecode.com/svn/trunk/HostsX.orzhosts
sudo mv hosts /etc/hosts
sudo chmod 0644 /etc/hosts
sudo gedit /etc/hosts
