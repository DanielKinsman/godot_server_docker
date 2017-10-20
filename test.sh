#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

docker build . --tag "godot_server:test"

rm -f x11game data.pck androidgame.apk

docker run -v $DIR:/mnt/working "godot_server:test" godot_server -v -path /mnt/working/test_project -export "Linux X11" /mnt/working/x11game
if [ -f x11game ]
then
    echo "Linux X11 export successful"
else
    (>&2 echo "Linux X11 export FAILED")
    exit 1
fi

docker run -v $DIR:/mnt/working "godot_server:test" godot_server -v -path /mnt/working/test_project -export_debug "Android" /mnt/working/androidgame.apk
if [ -f androidgame.apk ]
then
    echo "Android export successful"
else
    (>&2 echo "Android export FAILED")
    exit 1
fi
