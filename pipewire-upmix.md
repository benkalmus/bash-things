THis was a PITA to figure out. 
Basically, pipewire config is gen'd in /usr/share/pipewire....
copy those files to /etc/pipewire
BUT FIRST

grep upmix configs and set them to true!
then copy the files over to: 

sudo nano /etc/pipewire/pipewire-pulse.conf

and run 
systemclt restart --user --now pipewire-pulse pipewire

hope that helps
