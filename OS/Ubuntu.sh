#!/bin/bash
sudo mv /etc/hosts /etc/hosts.bak
wget -O /tmp/HostsX.orzhosts http://hostsx.googlecode.com/svn/trunk/HostsX.orzhosts
sudo mv /tmp/HostsX.orzhosts /etc/hosts
sudo chmod 0644 /etc/hosts
sudo gedit /etc/hosts
