#!/usr/bin/env bash

sudo apt update
sudo apt install -y apache2
if ! [ -L /var/www ]; then
  sudo rm -rf /var/www
  sudo ln -fs /vagrant /var/www
fi
