#!/bin/bash
######################
#
# Script  : get_connectors.sh
# Function: Collect connector data
# Input   : Connector API
# Output  : data file for zabbix LLDiscovery
# Usage   : by zabbix
# User    : root
# Version : 2.0 / 02/12/2022  - Azure version
# Owner   : ronald.schouw@gmail.com
######################

TIME=$(date +"%d-%m-%y:%R")

echo "Even een paar seconde ...."

curl --progress-bar http://localhost:8382/connectors?expand=status | jq '.[]' > /tmp/connector-$TIME

while true; do
    read -p "Output van de connectoren op het scherm printen ? y/n " keuze
    case $keuze in
        [YyjJ]* ) less /tmp/connector-$TIME
                exit 1;;
        [Nn]* ) echo "De output van de connector list staat in /tmp/connector-$TIME"
                exit 1;;
        * ) echo "Alleen j/y of n.";;
    esac
done