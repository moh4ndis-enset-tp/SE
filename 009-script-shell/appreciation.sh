#!/bin/bash

# Fonction pour afficher l'appréciation en fonction de la note
afficher_appreciation() {
    note=$1
    
    # Vérifier si la note est un nombre
    if ! [[ $note =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        echo "Erreur: Veuillez entrer un nombre valide."
        return
    fi
    
    # Déterminer l'appréciation en fonction de la note
    if (( $(echo "$note > 20 || $note < 0" | bc -l) )); then
        echo "Erreur: La note doit être comprise entre 0 et 20."
    elif (( $(echo "$note >= 16 && $note <= 20" | bc -l) )); then
        echo "très bien"
    elif (( $(echo "$note >= 14 && $note < 16" | bc -l) )); then
        echo "bien"
    elif (( $(echo "$note >= 12 && $note < 14" | bc -l) )); then
        echo "assez bien"
    elif (( $(echo "$note >= 10 && $note < 12" | bc -l) )); then
        echo "moyen"
    elif (( $(echo "$note < 10" | bc -l) )); then
        echo "insuffisant"
    fi
}

# Boucle principale du programme
while true; do
    echo "Entrez une note (ou 'q' pour quitter) : "
    read saisie
    
    # Vérifier si l'utilisateur souhaite quitter
    if [ "$saisie" = "q" ] || [ "$saisie" = "Q" ]; then
        echo "Au revoir!"
        break
    fi
    
    # Afficher l'appréciation pour la note saisie
    appreciation=$(afficher_appreciation "$saisie")
    echo "Appréciation: $appreciation"
    echo "-----------------------"
done