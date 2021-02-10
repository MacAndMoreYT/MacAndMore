# Pritunl - VPN im LXC Container

### 0. (Nur im LXC)
- Prev. Container
```shell
crontab -e
@reboot sh /root/tun-tap.sh
```
```shell
nano  /root/tun-tap.sh
```
```text
mkdir -p /dev/net
mknod -m 666 /dev/net/tun c 10 200
```
- Reboot

### 1. Install via Script
```shell
wget https://git.ts13.myds.me/puplic/lxc/-/raw/master/Pritunl%20-%20VPN/install.sh && bash install.sh
```

### 2. Key und Passwort erhalten
```shell
sudo pritunl setup-key
sudo pritunl default-password
```

### 3. In der Web GUI (Siehe Video)
- Set Username / Password
- Set Puplic Address = DDNS
- Create Organization
- Create User
- Create OpenVPN Server
