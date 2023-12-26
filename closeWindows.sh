#!/bin/bash 
# Esto es para indicar que usamos el interprete de bash
ids=$(wmctrl -l)

cantidadProcesos=$(echo "$ids" | grep -c $'\n')

n=10

# Usamos awk para imprimir los primeros n caracteres después de cada salto de línea
resultado=$(echo "$ids" | awk -v n="$n" '{print substr($0, 1, n)}')

arrayconpid=()
arrayconpid+=($resultado) 

for id in "${arrayconpid[@]}"; do
  
  pid=$(xprop _NET_WM_PID -id $id)
  pid=${pid:24}

  kill -15 $pid # uso de SIGTERM. Permite operaciones de limpieza antes de cerrar
  
done

aplicacionesextraacerrar=("gnome-control-c" "gnome-terminal-" "gedit" "nautilus")


for app in "${aplicacionesextraacerrar[@]}"; do
  if [[ "$(pgrep $app)" != "" ]];then
  pkill $app # uso de SIGTERM. Permite operaciones de limpieza antes de cerrar
  fi

done