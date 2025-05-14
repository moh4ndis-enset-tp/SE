# recycle

`on linux - ubuntu`

## Create the folder:

```
mkdir -p ~/bin
```

## Add to PATH

### 🐧 For Linux (bash):

> Edit .bashrc:

```
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
```

> Then apply it:

```
source ~/.bashrc
```

> Verifier

```
echo $PATH
```

### 🍎 For macOS (zsh by default):

> Edit .zshrc:

```
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
```

> Then apply it:

```
source ~/.zshrc
```

> Verifier

```
echo $PATH
```

```
cp recycle.sh ~/bin/
chmod +x ~/bin/recycle.sh

```

## Make your script executable:

```
chmod +x ~/bin/recycle
```

## Run your script from anywhere:

```
recycle
```

## Verify:

```
which recycle
```

Output should be:

```
/home/youruser/bin/recycle   # Linux
/Users/youruser/bin/recycle # macOS
```

## Préparez quelques fichiers de test :

```
# Creez un répertoire de test
mkdir ./test_recycle
cd test_recycle
```

# Créez quelques fichiers exemples

```
touch fichier1.txt
touch fichier2.txt
touch fichier3.txt
```

### Tests des différentes fonctionnalités :

> Déplacer des fichiers vers la corbeille :

```
# Déplacer un ou plusieurs fichiers
recycle fichier1.txt fichier2.txt
```

> Lister le contenu de la corbeille :

```
recycle -l
```

> Vider la corbeille :

```
recycle -r
```

> Vérifier le comportement en cas d'erreur :

```
# Essayer de déplacer un fichier inexistant
recycle fichier_inexistant.txt
```

> Tester sans arguments :

```
recycle
```

# backup

```
chmod +x backup.sh
```

```
echo "Ceci est un fichier de test." > exemple.txt

```

```
./backup.sh
```

```
ls OLD
```
