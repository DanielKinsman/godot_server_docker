A docker image for exporting godot projects to various formats.
===============

Export a godot project to linux:

    docker run -v /home/user/some/directory/:/mnt/working godot_server godot_server -v -path /mnt/working/godot_project -export "Linux X11" /mnt/working/game

Android (debug):

    docker run -v /home/user/some/directory/:/mnt/working godot_server godot_server -v -path /mnt/working/godot_project -export_debug "Android" /mnt/working/game.apk


Alternatively, how to build to docker image (if you want to do that rather than just installing it from docker hub):

    cd /path/to/dockerfile
    docker build . --tag godot_server:latest
