# seedpot

Seedpot is an all-in-one scheduled torrenting utility which makes use of docker to provide unfailing anonymity through openvpn.

## configuration

### environmental variables

Environmental variables can be configured in the .env file, and can also be overridden by any provided on the command line.

PGID and PUID refer to the user ID with which the container will create files and should be set to that of your current user to ensure that created files will be owned by your account.

To find your current PGID and PUID, run `id`

### openvpn

Your VPN provider's .ovpn configs/certs/secrets should go in the ./openvpn folder.

Any paths in these files (crl-verify, auth-user-pass, etc) should refer to `/vpn`, as that is where the internal openvpn container mount is located.

Only one .ovpn config should be included, as the container will attempt to negotiate a connection with each config it finds.

An example PrivateInternetAccess config is included, with dummy credentials.

A note: In order to make Docker - and thus seedpot - work behind an openvpn client, please refer to [this](https://stackoverflow.com/questions/45692255/how-make-openvpn-work-with-docker) stackexchange post for instructions on modifying your IP routes

## running

`./run.sh` - it's that simple.

### errors

Seedpot not running? Wait a minute. To avoid race conditions, there is a container start hierarchy, and the service will only become available once all containers have started.

If errors occur, `docker-compose logs` will show container-wide messages, and the application config subdirectories also contain logfiles.

The most common error is misconfiguration of openvpn credentials.

## software

Seedpot comes with rtorrent/rutorrent, sonarr, radarr, and jackett, with these services configured out of the box to connect to each other.
