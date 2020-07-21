## Links
- [Font Awesome cheatsheet](https://fontawesome.com/cheatsheet)
- [Unicode characters supporded by DejaVu font](https://www.fileformat.info/info/unicode/font/dejavu_sans/list.htm)
- [ASCII generator](http://patorjk.com/software/taag/#p=display&f=Ogre&t=)

## Fast configuration
Script `./link` creates symlinks to all dotfiles in this repo. The list of files is hardcoded inside the script. 
If all necessary packages are installed, command `.\link --create-links` should carry out all configuration work.
There might be bugs.

## Modules blacklist
Put this to `/etc/modprobe.d/user-blacklist.conf`:
```
blacklist pcspkr
blacklist bnep
blacklist btusb
blacklist bluetooth
blacklist uvcvideo
```

## brightnessctl setup
Recently I moved from `xbacklight` package to `brightnessctl` -- there are less problems to face.
After installation add your user to `video` group and reboot:
```
sudo usermod -aG video <username>
```

## ifup/ifdown without password
Create file `/etc/sudoers.d/custom_rules` and write there:
```
vasily ALL=(ALL) NOPASSWD:/sbin/ifdown enp3s0,/sbin/ifup enp3s0
```
Now you don't need a password, but still need to write `sudo` before these commands.

## Hooks
This repo uses some hooks. They are located in `.githooks` directory so that they could be tracked. 
To tell `git` where to look for these hooks run
```
git config core.hooksPath .githooks
```
