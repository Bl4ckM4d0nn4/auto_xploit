#!/bin/bash

ip=$1
echo $'\e[1;37m'"    __          _        __   __      _       _ _"$'\e[0m'
echo $'\e[1;33m'"   /  \        | |       \ \ / /     | |     (_) |"$'\e[0m'
echo $'\e[1;31m'"  / /\ \  _  _ | |____    \ V / _ __ | | ___  _| |_"$'\e[0m'
echo $'\e[1;35m'" / /__\ \| || ||  / _ \   /   \| '_ \| |/ _ \| | __|"$'\e[0m'
echo $'\e[1;34m'"|  ____  | || || | (_) | / /^\ \ |_) | | (_) | | |_"$'\e[0m'
echo $'\e[1;32m'"|_|    |_|\___|\__\___/ \ /   \/ .__/|_|\___/|_|\__|"$'\e[0m'
echo $'\e[1;37m'"                                | |                  "$'\e[0m'
echo $'\e[1;33m'"                                |_|                  "$'\e[0m'
echo ""
echo ""
echo $'\e[1;32m'"Running basic Nmap scan on all ports"$'\e[0m'
echo $'\e[1;31m'"Sit tight. This could take a while..."$'\e[0m'
echo ""
echo ""


#run nmap on all ports and output into txt file
#in the current working directory
#Takes one arugument from auto_xploit.sh
nmap -p- $ip -T4 -oN total_xploit.txt --stats-every 60s


#grep nmap report for all open ports
ports=$(grep -i 'open' total_xploit.txt | sed 's/\// /g' | awk {'print $1'} | xargs | sed 's/ /,/g')

echo ""
echo ""
echo $'\e[1;31m'"Running a deep scan on the following OPEN ports..."$'\e[0m'
echo $ports
echo ""

#run deep nmap scan on open ports
nmap -A -sV -vv -p $ports $ip -oX total_xploit.xml

echo ""
echo ""
echo $'\e[1;32'"Querying Searchsploit for services running on all open ports..."$'\e[0m'

searchsploit --nmap total_xploit.xml
