#!/bin/bash 
# Esto es para indicar que usamos el interprete de bash

# Usamos wmctrl -l -x para obtener una los nombres de los programas que estan en la tercera columna 
ids=$(wmctrl -l -x | awk '{print $3}')

Procesos=($ids)

aplicacionesextraacerrar=("gnome-control-c" "gnome-terminal-" "gedit" "nautilus")

for line in "${Procesos[@]}"; do
  
# Cortamos el string para obtener el nombre de la app:
  result=$(echo "$line" | awk -F '[.-]' '{print $1}')
  result="${result,,}" # Put to lowercase
  
# Agregamos el nombre a los otros nombres:
  aplicacionesextraacerrar+=($result)

done


for app in "${aplicacionesextraacerrar[@]}"; do
  if [[ "$(pgrep $app)" != "" ]];then
  pkill $app # uso de SIGTERM. Permite operaciones de limpieza antes de cerrar
  fi

done