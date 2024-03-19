THis was a PITA to figure out. 
Basically, pipewire config is gen'd in /usr/share/pipewire....
copy those files to /etc/pipewire
BUT FIRST

grep upmix configs and set them to true!

these will apply system-wide
then copy the files over to

```sh
sudo nano /etc/pipewire/pipewire-pulse.conf
```

and run 
```sh
systemctl restart --user --now pipewire-pulse pipewire
```


=========== Updated instructions! ========
Applied to local user account only

create dir `mkdir -p ~/.config/pipewire/pipewire-pulse.conf.d/`
new file
```
vim pipewire-pulse.conf

# paste in upmix.conf
```
