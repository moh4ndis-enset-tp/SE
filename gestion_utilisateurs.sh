#!/bin/bash

# Fonction pour afficher le menu
afficher_menu() {
    echo "--- Gestion des Utilisateurs ---"
    echo "1. Lister les utilisateurs"
    echo "2. Vérifier l'existence d'un utilisateur"
    echo "3. Créer un utilisateur"
    echo "4. Quitter"
    echo "-------------------------------"
}

# Fonction pour lister les utilisateurs
lister_utilisateurs() {
    echo "Liste des utilisateurs (UID > 1000) :"
    awk -F: '$3 > 1000 {print $1}' /etc/passwd
}

# Fonction pour vérifier l'existence d'un utilisateur
verifier_utilisateur() {
    read -p "Entrez un login ou un UID : " recherche
    
    # Vérifier si la recherche est numérique (supposé être un UID)
    if [[ "$recherche" =~ ^[0-9]+$ ]]; then
        # Recherche par UID
        utilisateur=$(awk -F: '$3 == '"$recherche"' {print $1}' /etc/passwd)
        if [ -n "$utilisateur" ]; then
            echo "Utilisateur trouvé par UID : "
            getent passwd "$recherche"
            return 0
        fi
    else
        # Recherche par login
        if id "$recherche" &>/dev/null; then
            echo "Informations de l'utilisateur : "
            getent passwd "$recherche"
            return 0
        fi
    fi
    
    echo "Utilisateur non trouvé."
    return 1
}

# Fonction pour créer un utilisateur
creer_utilisateur() {
    # Vérifier que le script est exécuté par root
    if [[ $EUID -ne 0 ]]; then
        echo "Erreur : Ce script doit être exécuté par root" 
        return 1
    fi
    
    # Demander le nom d'utilisateur
    read -p "Entrez le nom de login du nouvel utilisateur : " login
    
    # Vérifier si l'utilisateur existe déjà
    if id "$login" &>/dev/null; then
        echo "Erreur : L'utilisateur $login existe déjà."
        return 1
    fi
    
    # Vérifier si le répertoire personnel existe déjà
    if [ -d "/home/$login" ]; then
        echo "Erreur : Un répertoire /home/$login existe déjà."
        return 1
    fi
    
    # Demander un mot de passe
    read -s -p "Entrez un mot de passe pour $login : " mdp
    echo
    
    # Créer l'utilisateur
    useradd -m "$login"
    
    # Définir le mot de passe
    echo "$login:$mdp" | chpasswd
    
    echo "Utilisateur $login créé avec succès."
    echo "Répertoire personnel : /home/$login"
}

# Boucle principale
while true; do
    afficher_menu
    
    read -p "Choisissez une option (1-4) : " choix
    
    case $choix in
        1)
            lister_utilisateurs
            ;;
        2)
            verifier_utilisateur
            ;;
        3)
            creer_utilisateur
            ;;
        4)
            echo "Au revoir!"
            exit 0
            ;;
        *)
            echo "Option invalide. Veuillez choisir une option entre 1 et 4."
            ;;
    esac
    
    # Pause entre les actions
    read -n 1 -s -r -p "Appuyez sur une touche pour continuer..."
    echo
done