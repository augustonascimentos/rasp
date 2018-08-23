#!/bin/bash
#
#Preparando SD para deploy em Raspberry
#

#Variáveis
SD="/dev/mmcblk0"

#Desmontando partições, caso haja
umount -fv /dev/mmcblk0p1
umount -fv /dev/mmcblk0p2

#Sequencia de parâmetros para o fdisk
echo "o
p
n
p
1

+100M
t
c
n
p
2


w
"|fdisk $SD

#Formatando as partições
mkfs.vfat -Fv /dev/mmcblk0p1
mkfs.ext4 -Fv /dev/mmcblk0p2

#Criando diretórios boot e root
mkdir -p boot root

#Motando o sd nos diretórios
mount -v /dev/mmcblk0p1 boot
mount -v /dev/mmcblk0p2 root

#Download da imagem
#wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-2-latest.tar.gz

#Extraindo os arquivos da imagem
bsdtar -xvpf ArchLinuxARM-rpi-2-latest.tar.gz -C root
sync
#Movendo os arquivos para o diretório boot
mv -v root/boot/* boot

#Desmontando root e boot
#umount -v boot root
umount -v boot
umount -v root
rm -rf -v boot root
echo "SRCIPT FINALIZADO!"
