###### me@midi:~$ cat memo.md

Execute to add this cheatsheet to splash screen:
```bash
echo 'cat ./root-manifest-welcome/memo.md' >> ~/.bashrc
```

Note: Testing post commit hook to copy memo.md to README.md and stage it for commit;
Note: To update this file `cd ~/root-manifest-welcome/ && git pull && cd -`


# Hello RPi Root

## Hardware

dmesg | grep -i voltage -- voltage and undervoltage notifications
nmcli connection show -- RPI with NetworkManager package to manage network interfaces
nmtui -- NetworkManager UI
put into /etc/NetworkManager/conf.d/ one .conf file

```bash wifi-powersave-off.conf
# File to be place under /etc/NetworkManager/conf.d
[connection]
# Values are 0 (use default), 1 (ignore/don't touch), 2 (disable) or 3 (enable).
wifi.powersave = 2
```

# Hello Midi Root

## Locale Management
- `dpkg-reconfigure locales`

## TAR Archiver
- Make archive: `tar czf /home/landing/hls.tar.gz -C /var/www/html hls`
- View archive: `tar tzf archive.tar.gz`
- Unarchive to current user: `tar xzf archive.tar.gz`
- Unarchive to specified path `tar xzf archive.tar.gz -C .`

## Privilegies Status
- `visudo` -- use to offer sudo commands to users
- `sudo cat /etc/sudoers` -- show members of sudo group
- `getent group sudo` -- show the members of group sudo
- `getnet group wheel` - show the members of group wheel
- `cat /etc/group | grep sudo` - show the members of group sudo


## User Management
- `sudo adduser newuser` -- create new user


### Add to sudoers
- `sudo usermod -a -G sudo <username>` -- recommended way to add to sudoers
- `sudo adduser newuser sudo` -- add to sudoers
- `sudo usermod newuser -a -G pi,adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,spi,i2c,gpio` -- add the newuser to the same groups as the - "pi" user
- `export EDITOR="vim" sudo visudo` -- add to end of the file "<username> ALL=(ALL) ALL"
- `echo ' username ALL=(ALL)   ALL' >> /etc/sudoers` -- on CentOS as root
- `sudo sh -c "echo 'username ALL=NOPASSWD: ALL' >> /etc/sudoers"` -- grants root access to username without explicitly logging in as root


### Revoke sudo
- `sudo deluser new sudo` -- remove username from group sudo
- `sudo gpasswd -d username sudo` -- remove username from group sudo


### Apps with Open Network Access
- `ss -tunlp | grep 1880` -- какие приложения юзают порт
- `sudo netstat -tunlp` -- смотрим какие порты какие приложения юзают на открытие


### Service Management
By default Debian have systemd by default system init.
update-rc.d is from another system init called `System V`
`service`, `update-rc.d` is a legacy systems so consider focus on `systemctl`

- `systemctl start <service_name>`: Starts a specific service.
- `systemctl stop <service_name>`: Stops a running service.
- `systemctl restart <service_name>`: Restarts a service.
- `systemctl status <service_name>`: Displays the status of a service.
- `systemctl enable <service_name>`: Enables a service to start on boot.
- `systemctl disable <service_name>`: Disables a service from starting on boot.
- `systemctl mask <service_name>`: Masks a service, preventing it from being started, even if another service requires it.
- `systemctl reboot`: Reboots the system.
- `systemctl poweroff`: Shuts down the system.
- `systemctl list-units`: Lists all active units. (--type=service to filter by startup services)
- `systemctl list-unit-files`: Lists all unit files.
- `systemctl set-default multi-user.target`: Run system only to console, `graphical.target` to GUI

### LOGS
- `sudo journalctl -u ssh`
- `sudo tail -f /var/log/auth.log`
- `sudo journalctl --system --follow -u ssh.service`


### Login
- `sudo -iu <username>`  # start a login shell with sudo logging with interactive mode for a specific user
- `sudo -iu nodered`    # -c "ls -la"
- `su - <username>`     # legacy way? not recommended

### DIFF 
- `diff -ruN myproject myproject-copy`      # for example to compare two .git directories of different projects :)


### GIT
- `git log --graph --all | less` - show commits for current branch
- `git show <short-hash>`       # show omni information depends of it type (commits, tags, blobs, trees)
- `git checkout <commit SHA>`       # switch to `DETACHED HEAD` mode
- `git checkout -b <into_new_branch_name>`      # creates new branch off of the current branch

- `git checkout -`      # switch to last previous branch (like cyclic single alt+tab switches between two windows)

- `git reset --soft HEAD~1`     # rollback to previous HEAD and put commited data to commit
- `git diff HEAD~1 HEAD -- <file>`      # 
- `git reset --soft HEAD@{2}       # Move the HEAD, and just the HEAD, two commits back!
- `git reflog`                  # reverts `git reset --hard` 


### GITHUB
- `ssh-keygen -t ed<tab>`
- `eval "$(ssh-agent -s)"`
- `ssh-add <key_to_path_not_pub>`

**Warning**
Use deploy keys for read-only (set write access via github repository settings) access to specific repositories! Make moar keys!!!11


### NGINX
- `cd /etc/nginx/sites-enables/ && ln -s ../sites-available/my-very-own.conf .`     # create soft-link
- `nginx -t`    # check everything in configs 


- `nginx -t -c /etc/nginx/nginx.conf` -- to check config file ok? (-c is optional, nginx.conf by default)
- `tail -f /var/log/nginx/error.log`   # to see log
- `nano /etc/nginx/nginx.conf`         # edit
- logs in `/var/log/nginx/acces.log`

### Multitail
`multitail -f -n 2 cron.log /var/log/auth.log /var/log/nginx/access.log`

### MAINTENANCE
Do not forget to git push after changes in this memo.md file.

***

