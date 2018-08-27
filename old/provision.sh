#!/bin/bash

# Seta o padrao do teclado para BR-ABNT2
localectl set-keymap --no-convert br-abnt2

# Atualizando os pacotes
pacman-key --init
pacman-key --populate archlinuxarm
pacman -Syu --noconfirm

# Instalando os pacotes basicos
pacman -S --noconfirm base-devel sudo wget

# Definindo o Hostname do Equipamento
echo Digite o Hostname do equipamento:
read hostname
echo $hostname > /etc/hostname
echo O Hostname $hostname foi definido com sucesso!

# Liberando o acesso via SSH e bloquando acesso como root
sed -i -e 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
sed -i -e 's/#AddressFamily any/AddressFamily any/g' /etc/ssh/sshd_config
sed -i -e 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g' /etc/ssh/sshd_config

#Criando Usuario Padrão
useradd -m -g users -G wheel -s /bin/bash build

# Delegando permissões para o usuário build
sed -i -e 's/#%wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers

# Instalando o X Server
pacman -S --noconfirm xorg-server xorg-xinit xorg-xrandr

# Instalando o Docker Engine
pacman -S --noconfirm docker

# Adicionar o usu�rio build no /etc/sudores

# Download XLOGIN
wget https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=xlogin-git -O PKGBUILD

# Montando o XLOGIN
cd /home/build
sudo -u build makepkg -si

# Instalando o Chromium
pacman -S --noconfirm chromium

# Desabilitando os usuarios padroes do Raspberry

# Resetando o sistema para carregar todas a configuracoes
#
reboot
