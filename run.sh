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

pprint "Ensuring that docker-compose is installed"
ensure_compose
pprint "Stopping current instance, if it exists"
sudo docker-compose down -t 0 --remove-orphans
pprint "Starting new instance"
sudo docker-compose up -d --build
