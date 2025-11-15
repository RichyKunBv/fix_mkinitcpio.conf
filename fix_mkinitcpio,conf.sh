#!/bin/bash


CONF_FILE="/etc/mkinitcpio.conf"
BACKUP_FILE="/etc/mkinitcpio.conf.bak"

if [ "$EUID" -ne 0 ]; then
  echo "Ejecuta con sudo pndejo"
  exit 1
fi

if [ ! -f "$CONF_FILE" ]; then
  echo "No se encontró $CONF_FILE. No estas afectado."
  exit 0
fi


if grep -q 'o"$' "$CONF_FILE"; then
  echo "¡Error detectado! Se encontró 'o\"' al final de $CONF_FILE."
  
  echo "Creando respaldo en $BACKUP_FILE..."
  cp "$CONF_FILE" "$BACKUP_FILE"
  

  echo "Reparando el archivo..."
  sed -i 's/o"$//' "$CONF_FILE"
  
  echo "¡Archivo reparado!"
  
  echo "Regenerando el initramfs (esto es crucial)..."
  mkinitcpio -P
  
  echo "-----------------------------------------------------"
  echo "¡Proceso completado! El sistema debería arrancar."
  echo "Se guardó un respaldo en $BACKUP_FILE."
  echo "-----------------------------------------------------"
  
else
  echo "No se encontró el error 'o\"' en $CONF_FILE."
  echo "Tu sistema parece estar bien."
fi
