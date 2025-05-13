#!/bin/bash

# Affiche le nombre de paramètres
echo "Bonjour, vous avez rentré $# paramètres."

# Affiche le nom du script
echo "Le nom du script est $0"

# Affiche le 3ème paramètre (s'il existe)
if [ $# -ge 3 ]; then
    echo "Le 3ème paramètre est $3"
else
    echo "Le 3ème paramètre est inexistant"
fi

# Affiche la liste des paramètres
echo "Voici la liste des paramètres : $@"