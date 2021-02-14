# Mount DVB Card in LXC

```shell
nano /etc/pve/lxc/id.conf
```
```text
lxc.cgroup.devices.allow: c 212:* rwm
lxc.mount.entry: /dev/dvb dev/dvb none bind,optional,create=dir
```
