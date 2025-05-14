#!/bin/bash

# Fonction pour afficher le menu
afficher_menu() {
    echo "--- Gestion des Utilisateurs ---"
    echo "1. Lister les utilisateurs"
    echo "2. Verifier l'existence d'un utilisateur"
    echo "3. Creer un utilisateur"
    echo "4. Supprimer un utilisateur"
    echo "5. Quitter"

    echo "-------------------------------"
}

# Fonction pour lister les utilisateurs
lister_utilisateurs() {
    echo "Liste des utilisateurs (UID > 1000) :"
    echo "------------------------------------"
    
    # Utiliser cut pour afficher uniquement le nom d'utilisateur (1er champ)
    # Filtrer uniquement les lignes où le 3eme champ (UID) est > 1000
    awk -F: '$3 >= 1000 && $3 < 65534 {print "Utilisateur: " $1 ", UID: " $3}' /etc/passwd
    echo "------------------------------------"
    echo "Total d'utilisateurs : $(awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd | wc -l)"
    # Si aucun utilisateur n'est trouve
    if [ -z "$(awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd)" ]; then
        echo "Aucun utilisateur avec UID > 1000 n'a ete trouve."
    fi
}

# Fonction pour verifier l'existence d'un utilisateur
verifier_utilisateur() {
    read -p "Entrez un login ou un UID : " recherche
    
    # Verifier si la recherche est numerique (suppose être un UID)
    if [[ "$recherche" =~ ^[0-9]+$ ]]; then
        # Recherche par UID
        utilisateur=$(awk -F: '$3 == '"$recherche"' {print $1}' /etc/passwd)
        if [ -n "$utilisateur" ]; then
            echo "Utilisateur trouve par UID : "
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
    
    echo "Utilisateur non trouve."
    return 1
}

# Fonction pour creer un utilisateur
creer_utilisateur() {
    # Verifier que le script est execute par root
    if [[ $EUID -ne 0 ]]; then
        echo "Erreur : Ce script doit être execute par root" 
        return 1
    fi
    
    # Demander le nom d'utilisateur
    read -p "Entrez le nom de login du nouvel utilisateur : " login
    
    # Verifier si l'utilisateur existe deja
    if id "$login" &>/dev/null; then
        echo "Erreur : L'utilisateur $login existe deja."
        echo "Details de l'utilisateur existant :"
        getent passwd "$login"
        return 1
    fi
    
    # Verifier si le repertoire personnel existe deja
    if [ -d "/home/$login" ]; then
        echo "Erreur : Un repertoire /home/$login existe deja."
        return 1
    fi
    
    # Demander un mot de passe
    read -s -p "Entrez un mot de passe pour $login : " mdp
    echo
    
    # Creer l'utilisateur avec un repertoire personnel
    useradd -m "$login" 2>/dev/null
    
    # Verifier si la creation a reussi
    if [ $? -ne 0 ]; then
        echo "Erreur lors de la creation de l'utilisateur. Verifiez les logs systeme."
        return 1
    fi
    
    # Definir le mot de passe
    echo "$login:$mdp" | chpasswd
    
    echo "Utilisateur $login cree avec succes."
    echo "Repertoire personnel : /home/$login"
}
# Fonction pour supprimer un utilisateur
# Fonction pour supprimer un utilisateur
supprimer_utilisateur() {
    # Verifier que le script est execute par root
    if [[ $EUID -ne 0 ]]; then
        echo "Erreur : Ce script doit être execute par root"
        return 1
    fi

    read -p "Entrez le login de l'utilisateur a supprimer : " login

    # Verifier si l'utilisateur existe
    if ! id "$login" &>/dev/null; then
        echo "Erreur : L'utilisateur $login n'existe pas."
        return 1
    fi

    # Demander confirmation
    read -p "Êtes-vous sûr de vouloir supprimer l'utilisateur $login ? (o/N) : " confirmation
    if [[ "$confirmation" =~ ^[Oo]$ ]]; then
        # Supprimer l'utilisateur et son repertoire personnel
        userdel -r "$login" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "Utilisateur $login supprime avec succes."
        else
            echo "Erreur lors de la suppression de l'utilisateur. Verifiez les permissions ou l'etat du systeme."
        fi
    else
        echo "Suppression annulee."
    fi
}


# Boucle principale
while true; do
    afficher_menu

    read -p "Choisissez une option (1-5) : " choix

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
            supprimer_utilisateur
            ;;
        5)
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