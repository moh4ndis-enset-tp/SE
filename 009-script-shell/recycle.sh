#!/bin/bash

# Definir le chemin de la corbeille dans le repertoire personnel
CORBEILLE="$HOME/corbeille"

# Fonction pour creer la corbeille si elle n'existe pas
creer_corbeille() {
    if [ ! -d "$CORBEILLE" ]; then
        mkdir -p "$CORBEILLE"
        echo "Corbeille creee : $CORBEILLE"
    fi
}

# Fonction pour lister le contenu de la corbeille
lister_corbeille() {
    creer_corbeille
    
    echo "Contenu de la corbeille :"
    
    # Verifier si la corbeille est vide
    if [ -z "$(ls -A "$CORBEILLE" 2>/dev/null)" ]; then
        echo "La corbeille est vide."
    else
        ls -la "$CORBEILLE"
    fi
}

# Fonction pour vider la corbeille
vider_corbeille() {
    creer_corbeille
    
    # Verifier si la corbeille est deja vide
    if [ -z "$(ls -A "$CORBEILLE" 2>/dev/null)" ]; then
        echo "La corbeille est deja vide."
    else
        rm -rf "$CORBEILLE"/*
        echo "La corbeille a ete videe."
    fi
}

# Fonction pour deplacer des fichiers vers la corbeille
deplacer_vers_corbeille() {
    creer_corbeille
    
    # Verifier s'il y a des fichiers a deplacer
    if [ $# -eq 0 ]; then
        echo "Erreur : Aucun fichier specifie."
        echo "Usage : recycle fichier1 fichier2 ..."
        exit 1
    fi
    
    # Deplacer chaque fichier vers la corbeille
    for fichier in "$@"; do
        if [ -e "$fichier" ]; then
            # En cas de conflit de nom, ajouter un timestamp
            base_nom=$(basename "$fichier")
            if [ -e "$CORBEILLE/$base_nom" ]; then
                timestamp=$(date +%Y%m%d_%H%M%S)
                mv "$fichier" "$CORBEILLE/${base_nom}_${timestamp}"
                echo "Deplace : $fichier vers $CORBEILLE/${base_nom}_${timestamp}"
            else
                mv "$fichier" "$CORBEILLE/"
                echo "Deplace : $fichier vers $CORBEILLE/$base_nom"
            fi
        else
            echo "Erreur : Le fichier '$fichier' n'existe pas."
        fi
    done
}

# Traitement des options et arguments
case "$1" in
    -l)
        lister_corbeille
        ;;
    -r)
        vider_corbeille
        ;;
    "")
        echo "Erreur : Option ou fichier(s) requis."
        echo "Usage : recycle [-l|-r] ou recycle fichier1 fichier2 ..."
        exit 1
        ;;
    *)
        deplacer_vers_corbeille "$@"
        ;;
esac

exit 0