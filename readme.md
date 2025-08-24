Deprecated, using this instead https://gitlab.com/DanielKinsman/godot-ci


A docker image for exporting godot projects to various formats.
===============

Grab it from dockerhub:

    docker pull danielkinsman/godot_server_docker

Export a godot project to linux:

    docker run -v /home/user/some/directory/:/mnt/working danielkinsman/godot_server_docker godot_server -v -path /mnt/working/godot_project -export "Linux X11" /mnt/working/game

Android (debug):

    docker run -v /home/user/some/directory/:/mnt/working danielkinsman/godot_server_docker godot_server -v -path /mnt/working/godot_project -export_debug "Android" /mnt/working/game.apk
