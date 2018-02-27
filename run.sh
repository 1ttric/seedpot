#!/bin/bash

set -e

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
    sudo apt -yqq install apache2-utils
    mkdir -p ./nginx/htpasswd/
    if [ ! -f ./nginx/htpasswd/.htpasswd ]; then
        pprint "Setting up credentials"
        echo -n "New username: "
        read user
        sudo htpasswd -c ./nginx/htpasswd/.htpasswd $user
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
