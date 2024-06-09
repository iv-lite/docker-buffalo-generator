#!/usr/bin/env bash

if [ -f /.dockerenv ]; then
    echo "Run this script outside of docker";
    exit 1;
fi

if [ ! -z $1 ] && [ ! $z $2 ]; then
    echo "Usage: bash -c docker-buffalo-generator.sh <project-name> <destination>";
    exit 1;
fi

if [ -d "storage/.engine" ]; then
    rm -rf "storage/.engine";
fi
repository="git@github.com:iv-lite/docker-boilerplates-buffalo.git"
git clone ${repository} storage/.engine

location="$(cd $(dirname $0) && pwd)"
destination="$(realpath $2)/"
flags=""
while [ -n $3 ]; do
    flags+=" $3"
    shift
done

cp .env.engine "${location}/storage/.engine/docker/.env"
cd storage/.engine/docker
bash tools/init.sh $1

mv ${location}/storage/.engine "${destination}/$1"