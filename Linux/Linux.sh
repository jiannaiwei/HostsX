#!/bin/bash
sudo mv /etc/hosts /etc/hosts.bak
wget http://kwoktree.googlecode.com/svn/trunk/hosts/SuHosts.txt
sudo mv hosts /etc/hosts
sudo /etc/init.d/networking restart