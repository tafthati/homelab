#!/bin/bash
echo "==== CHECKUP WIFI SERVER $(date '+%Y-%m-%d %H:%M:%S') ===="

echo ""
echo ">> Data e ora:"
date

echo""
echo ">> Test connessione a Internet:"
ping -c 1 8.8.8.8

echo""
echo ">> Test connessione a Internet:"
ping -c 1 1.1.1.1

echo""
echo ">> Test risoluzione DNS:"
ping -c 1 google.com

echo""
echo ">> Stato delle interface di rete:"
ip a

echo""
echo ">>Stato del firewall:"
if command -v ufw &>/dev/null; then
	sudo ufw status verbose
else
	echo " UFW non installato o non presente."
fi

echo""
echo ">>==== FINE CHECKUP ===="
