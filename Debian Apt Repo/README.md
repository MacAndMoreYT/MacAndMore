# Debian APT Repo Server

### 1. Pakete Installieren
```shell
apt update
apt install gnupg2 apache2 reprepro -y
```

### 2. GPG Key Generieren
```shell
gpg2 --full-gen-key
```
#### Antwort auf die Fragen
```text
Bitte wählen Sie, welche Art von Schlüssel Sie möchten:
   (1) RSA und RSA (voreingestellt)
```
```text
Welche Schlüssellänge wünschen Sie?
    4096
```
```text
Bitte wählen Sie, wie lange der Schlüssel gültig bleiben soll.
    0 = Schlüssel verfällt nie
```
```text
Key does not expire at all
        Is this correct? (y/N) y
```
```text
GnuPG needs to construct a user ID to identify your key.
        Real name: Key-Name
        E-Mail: E-Mail
        Comment:
        Password: password
```

### 3. Umgebung Erstellen
```shell
cd /var/www/html
rm -r *
mkdir repo
cd repo
mkdir debian
cd debian
mkdir conf
mkdir deb
cd conf
```

### 4. Bearbeiten der "Options"
```shell
nano options
```
```text
verbose
basedir /var/www/html/repo/debian
ask-passphrase
```

### 5. Bearbeiten der "distributions"
```shell
nano distributions
```
```text
Origin: Your project
Label: Your project
Codename: buster
Architectures: amd64
Components: main
Description: Apt repository
SignWith: #!Key-Name!
```

### 6. Repo Signieren und Schlüssel Veröffentlichen
```shell
cd /var/www/html/repo/debian
gpg --armor --output WASAUCHIMMER.gpg.key --export Key-Name
```

### 7. Pakete Hinzufügen

#### Download der Packages
```shell
cd /var/www/html/repo/debian/deb
wget URL ZUM DEB
```
#### Hinzufügen der Packages
```shell
cd /var/www/html/repo/debian
reprepro --ask-passphrase -V includedeb buster /var/www/html/repo/debian/deb/*.deb
```

### 8. Einbinden des Repos
```shell
echo "deb http://server-ip/repo/debian buster main" >> /etc/apt/sources.list
wget -O - http://server-ip/repo/debian/repo.gpg.key | sudo apt-key add -
```

### 9. Apache Web Server Absichern
```shell
nano /etc/apache2/conf-available/reprepro.conf
```
```text
# Apache HTTP Server 2.4

<Directory /var/www/html/repo/ >
        # We want the user to be able to browse the directory manually
        Options Indexes FollowSymLinks Multiviews
        Require all granted
</Directory>

# This syntax supports several repositories, e.g. one for Debian, one for Ubuntu.
# Replace * with debian, if you intend to support one distribution only.
<Directory "/var/www/html/repo/debian/db/">
        Require all denied
</Directory>

<Directory "/var/www/html/repo/debian/conf/">
        Require all denied
</Directory>

<Directory "/var/www/html/repo/debian/incoming/">
        Require all denied
</Directory>
```
#### Conf Aktiviren
```shell
a2enconf reprepro.conf
systemctl reload apache2
```
