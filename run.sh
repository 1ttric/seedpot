#!/bin/bash

cd "${0%/*}"

function pprint {
    echo "[seedpot] $1"
}

function ensure_compose {
    if [ -z $(which docker-compose) ]; then
        sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
    fi
}

function ensure_basicauth {
    sudo apt -yqq install apache2-utils 1>/dev/null 2>&1
    if [ ! -f ./nginx/htpasswd/.htpasswd_rutorrent ]; then
        pprint "Setting up rutorrent credentials"
        print -n "New username: "
        read user
        sudo htpasswd -c ./nginx/htpasswd/.htpasswd_rutorrent $user
    fi
    if [ ! -f ./nginx/htpasswd/.htpasswd_jackett ]; then
        pprint "Setting up jackett credentials"
        print -n "New username "
        read user
        sudo htpasswd -c ./nginx/htpasswd/.htpasswd_jackett $user
    fi
    if [ ! -f ./nginx/htpasswd/.htpasswd_sonarr ]; then
        pprint "Setting up sonarr credentials"
        print -n "New username "
        read user
        sudo htpasswd -c ./nginx/htpasswd/.htpasswd_sonarr $user
    fi
    if [ ! -f ./nginx/htpasswd/.htpasswd_radarr ]; then
        pprint "Setting up radarr credentials"
        print -n "New username "
        read user
        sudo htpasswd -c ./nginx/htpasswd/.htpasswd_radarr $user
    fi
}

pprint "Ensuring that docker-compose is installed"
ensure_compose
pprint "Ensuring nginx has basic auth enabled"
ensure_basicauth
pprint "Stopping existing instance, if it exists"
sudo docker-compose down -t 0 --remove-orphans
pprint "Starting new instance"
sudo docker-compose up -d