# fix_mkinitcpio.conf

Si tu Arch ya no arranca y te da "Kernel Panic", este script lo repara, pero debes ejecutarlo desde un Live USB (el instalador de Arch).

Pasos:

    Arranca desde tu USB de instalación de Arch.

    Conéctate a Internet (usa iwctl si es por Wi-Fi).

    Monta tus particiones. (¡Importante! Reemplaza sdaX y sdaY por las tuyas).
    Bash

# Monta tu partición raíz (la de '/')
mount /dev/sdaY /mnt

# Si tienes partición EFI (boot), móntala también
# mount /dev/sdaX /mnt/boot  (o /mnt/boot/efi)

Entra a tu sistema dañado con arch-chroot:


arch-chroot /mnt

Descarga el script https://raw.githubusercontent.com/RichyKunBv/fix_mkinitcpio.conf/refs/heads/main/fix_mkinitcpio%2Cconf.sh:


curl -L -o fix_mkinitcpio,conf.sh

Dale permisos y ejecútalo:


chmod +x fix.sh
sudo ./fix.sh

El script detectará el error, lo reparará y regenerará el initramfs (tardará un momento).

¡Listo! Sal del chroot, desmonta y reinicia:

exit
umount -R /mnt
reboot
