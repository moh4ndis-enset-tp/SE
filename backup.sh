#!/bin/bash

# Nom du répertoire de sauvegarde
BACKUP_DIR="OLD"

# Format de la date
DATE=$(date +%F)  # Format YYYY-MM-DD

# Vérifier si le répertoire OLD existe, sinon le créer
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir "$BACKUP_DIR"
    if [ $? -ne 0 ]; then
        echo "Erreur : impossible de créer le répertoire $BACKUP_DIR"
        exit 1
    fi
fi

# Parcourir les fichiers du répertoire courant (hors répertoires et OLD)
for file in *; do
    if [ -f "$file" ] && [ "$file" != "$0" ]; then
        cp "$file" "$BACKUP_DIR/${file}#${DATE}"
    fi
done

echo "Sauvegarde terminée avec succès dans le répertoire '$BACKUP_DIR'."
