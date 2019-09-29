## Установка Vagrant на Ubuntu
```
wget https://releases.hashicorp.com/vagrant/2.2.5/vagrant_2.2.5_x86_64.deb
dpkg -i vagrant_2.2.5_x86_64.deb
```
## Установка плагина Digital Ocean для Vagrant
```
vagrant plugin install vagrant-digitalocean
vagrant box add digital_ocean https://github.com/devopsgroup-io/vagrant-digitalocean/raw/master/box/digital_ocean.box
```
## Запуск
```
vagrant up
```
