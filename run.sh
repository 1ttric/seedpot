#!/bin/bash

cd "${0%/*}"

function install_compose {
    sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
}

if [[ -z $(which docker-compose) ]]; then
    install_compose
fi

sudo docker-compose down -t 0 --remove-orphans
sudo docker-compose up -d