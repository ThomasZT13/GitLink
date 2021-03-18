#!/bin/bash
#
# Created by: ThomasZT13
#
# GetLink
#
# VARIABLES
PWD=$(pwd)
source ${PWD}/Colors.sh
#
# FUNCIONES
#
trap 'printf "\n";stop;exit 1' 2
function GetLink {
	sleep 0.5
	clear
echo -e "${amarillo}
    ▄▄▄▄                       ▄▄           ██               ▄▄
  ██▀▀▀▀█              ██      ██           ▀▀               ██
 ██         ▄████▄   ███████   ██         ████     ██▄████▄  ██ ▄██▀
 ██  ▄▄▄▄  ██▄▄▄▄██    ██      ██           ██     ██▀   ██  ██▄██
 ██  ▀▀██  ██▀▀▀▀▀▀    ██      ██           ██     ██    ██  ██▀██▄
  ██▄▄▄██  ▀██▄▄▄▄█    ██▄▄▄   ██▄▄▄▄▄▄  ▄▄▄██▄▄▄  ██    ██  ██  ▀█▄
    ▀▀▀▀     ▀▀▀▀▀      ▀▀▀▀   ▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀  ▀▀    ▀▀  ▀▀   ▀▀▀
"${blanco}
}
function Menu_Ruta {
echo -e -n "${amarillo}
┌═══════════════════════════════┐
█ ${blanco}INGRESE LA RUTA DE SU ARCHIVO ${amarillo}█
└═══════════════════════════════┘
┃    ┌═════════════════════════════┐
└=>>>█ EJEMPLO => ${blanco}/sdcard/Download ${amarillo}█
┃    └═════════════════════════════┘
┃
└═>>> "${blanco}
read -r RUTA
}
function Menu_Nombre {
echo -e -n "${amarillo}
┌═════════════════════════════════┐
█ ${blanco}INGRESE EL NOMBRE DE SU ARCHIVO ${amarillo}█
└═════════════════════════════════┘
┃    ┌════════════════════════┐
└=>>>█ EJEMPLO => ${blanco}archivo.txt ${amarillo}█
┃    └════════════════════════┘
┃
└═>>> "${blanco}
read -r NOMBRE
}
stop() {
VERIFICAR_NGROK=$(ps aux | grep -o "ngrok" | head -n1)
VERIFICAR_PHP=$(ps aux | grep -o "php" | head -n1)
VERIFICAR_SSH=$(ps aux | grep -o "ssh" | head -n1)
if [[ $VERIFICAR_NGROK == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi
if [[ $VERIFICAR_PHP == *'php'* ]]; then
pkill -f -2 php > /dev/null 2>&1
killall -2 php > /dev/null 2>&1
fi
if [[ $VERIFICAR_SSH == *'ssh'* ]]; then
pkill -f -2 ssh > /dev/null 2>&1
killall ssh > /dev/null 2>&1
fi
if [[ -e sendlink ]]; then
rm -rf sendlink
fi
}
start() {
echo -e "${amarillo}
┌═══════════════════════════┐
█ ${blanco}Generando Enlace Ngrok... ${amarillo}█
└═══════════════════════════┘"${blanco}
cd ${RUTA} && php -S 127.0.0.1:3333 > /dev/null 2>&1 &
sleep 2
./ngrok http 127.0.0.1:3333 > /dev/null 2>&1 &
sleep 10
Enlace=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")

echo -e "${amarillo}┃
└═>>>${blanco} ${Enlace}/${NOMBRE}"

echo -e "${amarillo}
┌══════════════════════════════┐
█ ${blanco}ENVIAR EL ENLACE AL OBJETIVO ${amarillo}█
└══════════════════════════════┘
"${blanco}
}
ELIMINAR_INICIAR() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi
start
}
#
# CÓDIGO
#
GetLink
Menu_Ruta
sleep 0.5
Menu_Nombre
ELIMINAR_INICIAR

