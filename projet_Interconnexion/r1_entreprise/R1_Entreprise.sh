#!/bin/bash

# Mise en marche de OSPF
sed -i 's/ospfd=no/ospfd=yes/' etc/frr/daemons
cd usr/lib/frr 
./watchfrr zebra ospfd
cd ../../../

#Rajout des réseaux dans OSPF !!!!! NE FONCTIONNE PAS POUR RAISON OBSCURE !!!!!!!
vtysh
conf t
router ospf
network 120.0.98.0/23 area 0
exit
exit
exit

while true; do sleep 1000;
done
