#!/bin/bash

# Names of public/private keys

read -p $'\e[1;36mEnter the name of the Private Key file name [EX: homelab-private.key]\e[0m: ' private_name
echo " "
read -p $'\e[1;36mEnter the name of the Public Key file name [EX: homelab-public.pem]\e[0m: ' public_name
echo " "

# Generate Private Key
openssl genrsa -des3 -out "$private_name" 2048

# Generate Public Key
openssl req -x509 -new -nodes -key "$private_name" -sha256 -days 1825 -out "$public_name"

# Generate p12 file for client devices
echo " "
echo -e "\e[1;33mWould you like to generate a p12 file for client devices [Recommended]? [Y/N]\e[0m"
echo " "
read -n 1 yesorno

if [[ "$yesorno" =~ ^[Yy]$ ]]; then
    echo " "
    read -p $'\e[1;36mEnter a name for the p12 file [EX: homelab.p12]:\e[0m ' p12_name
    read -p $'\e[1;36mEnter a name (USE QUOTES) [EX: "My Root CA"]:\e[0m ' ca_name
    echo " "
    openssl pkcs12 -export -out "$p12_name" -inkey "$private_name" -in "$public_name" -name "$ca_name"
elif [[ "$yesorno" =~ ^[Nn]$ ]]; then
    echo " "
    echo -e "\e[1;33mSkipping...\e[0m"
else
    echo " "
    echo -e "\e[1;33mSkipping...\e[0m"
fi
