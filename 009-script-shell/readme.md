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

## Prepare some test files:

```
# Create a test directory
mkdir ./test_recycle
cd test_recycle
```

# Create some example files

```
touch file1.txt
touch file2.txt
touch file3.txt
```

### Test the different features:

> Move files to the recycle bin:

```
# Move one or more files
recycle file1.txt file2.txt
```

> List the contents of the recycle bin:

```
recycle -l
```

> Empty the recycle bin:

```
recycle -r
```

> Check behavior in case of error:

```
# Try to move a non-existent file
recycle non_existent_file.txt
```

> Test with no arguments:

```
recycle
```

# backup

```
chmod +x backup.sh
```

```
echo "This is a test file." > example.txt

```

```
./backup.sh
```

```
ls OLD
```
