# seedpot

Seedpot is an all-in-one scheduled torrenting utility making use of docker to provide anonymity through openvpn

## configuration

### environmental variables

Configuration variables can be found in the .env file

PGID and PUID refer to the user ID with which the container will create files and should be set to that of your current user to avoid having to take ownership of the created files.

To find your current PGID and PUID, run `id`

### openvpn

Your VPN provider's .ovpn configs/certs/secrets should go in the ./openvpn folder

Any paths in these configs (crl-verify, auth-user-pass, etc) should refer to `/vpn`, as that is where the internal openvpn container mount is located

Only one .ovpn config should be included, as the container will attempt to negotiate a connection with each config it finds

## running

`./run.sh` - it's that simple.

### errors

If errors occur, `docker-compose logs` will show container-wide messages, and the application config subdirectories also contain logfiles

## software

Seedpot comes with rtorrent with rutorrent ui, sonarr, radarr, and jackett