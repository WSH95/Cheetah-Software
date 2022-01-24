#/bin/bash

QT_VER="$(ls /opt/Qt5.14.0/ | grep 5 -m1)" # wsh_annotation: [CMAKE ERROR: Qt5 path conflict] set the right QT path

printf "${HOME}/Qt/${QT_VER}/gcc_64/"

