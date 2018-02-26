# seedpot

seedpot is an all-in-one scheduled torrenting utility making use of docker to provide anonymity through openvpn

## configuration

configuration variables can be found in the .env file

PGID and PUID refer to the user ID with which the container will create files and should be set to that of your current user to avoid having to take ownership of the created files.

to find your current PGID and PUID, run `id`

## running

`./run.sh` - it's that simple.

## software

seedpot comes with rtorrent with rutorrent ui, sonarr, radarr, and jackett