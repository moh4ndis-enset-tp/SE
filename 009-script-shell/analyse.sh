#!/bin/bash

# Affiche le nombre de parametres
echo "Bonjour, vous avez rentre $# parametres."

# Affiche le nom du script
echo "Le nom du script est $0"

# Affiche le 3eme parametre (s'il existe)
if [ $# -ge 3 ]; then
    echo "Le 3eme parametre est $3"
else
    echo "Le 3eme parametre est inexistant"
fi

# Affiche la liste des parametres
echo "Voici la liste des parametres : $@"