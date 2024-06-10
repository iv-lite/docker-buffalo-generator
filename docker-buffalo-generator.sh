#!/usr/bin/env bash

if [ -f /.dockerenv ]; then
    echo "Run this script outside of docker";
    exit 1;
fi

if [ -z $1 ] || [ -z $2 ]; then
    echo "Usage: bash -c docker-buffalo-generator.sh <project-name> <destination>";
    exit 1;
fi

sourcedir=$(dirname $0)
destination="$(realpath $2)/"
name=$1
flags=""
while [ ! -z $3 ]; do
    flags="$flags $3"
    shift
done

if [ -d $destination/$name ]; then
    echo "Destination folder already exists";
    exit 1;
fi

repository="git@github.com:iv-lite/docker-boilerplates-buffalo.git"
git clone $repository $destination/$name

cp $sourcedir/.env.buffalo $destination/$name/docker/.env
cd $destination/$name/docker
bash tools/init.sh $name $flags

if [ ! -d $destination/$name/src ]; then
    rm -rf $destination/$name;
fi