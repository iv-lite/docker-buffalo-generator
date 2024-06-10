#!/usr/bin/env bash

destination="${HOME}/.local/bin"

if [ ! -d $destination ]; then
    mkdir -p $destination;
fi

install() {
    cp ./docker-buffalo-generator.sh $destination/docker-buffalo-generator
    cp ./.env.buffalo $destination/
    echo "Script installed"
}

if [ ! -f $file ]; then
    install
fi

while true; do
    read -p "Overwrite previous installation? [Y/n] " response
    if [ "${response}" == 'Y' ]; then
        install; 
        break;
    elif [ "${response}" == 'n' ]; then
        break;
    fi
done