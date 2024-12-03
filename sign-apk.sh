#!/bin/bash

# Variables
KEYSTORE=$1
KEY_ALIAS=$2
KEYSTORE_PASS=$3
KEY_PASS=$4
APK_FILE=$5
SIGNED_APK_FILE=$6

# Vérifier que tous les arguments sont fournis
if [ "$#" -ne 6 ]; then
    echo "Usage: $0 <keystore> <key_alias> <keystore_pass> <key_pass> <apk_file> <signed_apk_file>"
    exit 1
fi

# Signer l'APK
apksigner sign --ks "$KEYSTORE" --ks-key-alias "$KEY_ALIAS" --ks-pass pass:"$KEYSTORE_PASS" --key-pass pass:"$KEY_PASS" --out "$SIGNED_APK_FILE" "$APK_FILE"

# Vérifier si la signature a réussi
if [ $? -eq 0 ]; then
    echo "APK signé avec succès : $SIGNED_APK_FILE"
else
    echo "Erreur lors de la signature de l'APK"
    exit 1
fi
