#!/bin/bash

# Mettre les interfaces réseau en état actif
ip link set dev eth1 up
ip link set dev eth2 up

# Configurer les adresses IP sur les interfaces
ip addr add 192.168.1.2/24 dev eth1   # Adresse IP du réseau local (eth1)
ip addr add 120.0.96.3/23 dev eth2    # Adresse IP du réseau externe (eth2)

# Ajout de routes (ajusté pour des besoins réalistes)
ip route add 192.168.1.0/24 dev eth1  # Route pour le réseau local
ip route add 120.0.96.0/23 dev eth2   # Route pour le réseau externe

# Activer le forwarding IP pour permettre le routage entre eth1 et eth2
echo 1 > /proc/sys/net/ipv4/ip_forward

# Démarrer le serveur DHCP (supposant ISC DHCP)
service isc-dhcp-server restart

# Démarrer RIP (avec FRRouting ou Quagga)
service frr restart

# Configurer les règles NAT avec iptables (masquerading)
iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE  # Sortie via eth2

# Boucle infinie pour garder le script en exécution si nécessaire
while true; do
    sleep 1000;
done