#!/bin/bash

key_path=/home/${USER}/.ssh/id_rsa.pub
inventory=inventory.ini

sudo ansible all -u root -i ${inventory} -m user -a "name=${USER} state=present"
sudo ansible all -u root -i ${inventory} -m shell -a "echo \"${USER}       ALL=(ALL)  NOPASSWD:ALL\" >/etc/sudoers.d/${USER} "
sudo ansible all -u root -i ${inventory} -m authorized_key -a "user=${USER} state=present key=\"{{lookup(\'file\',\'${key_path}\')}}\""
