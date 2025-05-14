#!/bin/bash

# Nom du repertoire de sauvegarde
BACKUP_DIR="OLD"

# Format de la date
DATE=$(date +%F)  # Format YYYY-MM-DD

# Verifier si le repertoire OLD existe, sinon le creer
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir "$BACKUP_DIR"
    if [ $? -ne 0 ]; then
        echo "Erreur : impossible de creer le repertoire $BACKUP_DIR"
        exit 1
    fi
fi

# Parcourir les fichiers du repertoire courant (hors repertoires et OLD)
for file in *; do
    if [ -f "$file" ] && [ "$file" != "$0" ]; then
        cp "$file" "$BACKUP_DIR/${file}#${DATE}"
    fi
done

echo "Sauvegarde terminee avec succes dans le repertoire '$BACKUP_DIR'."
