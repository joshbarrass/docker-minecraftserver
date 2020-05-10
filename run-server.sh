#!/bin/bash

cd /server

TORUN="java -XX:+UseConcMarkSweepGC"

if [ ! -f /server/spigot.jar ];
then
    cp /spigot/spigot-*.jar /server/spigot.jar
    echo "Copied spigot.jar" 
fi

if [ ! -z "$MMIN" ];
then
    TORUN="$TORUN -Xms$MMIN"
    echo "Set min memory to $MMIN"
fi

if [ ! -z "$MMAX" ];
then
    TORUN="$TORUN -Xmx$MMAX"
    echo "Set max memory to $MMAX"
fi

TORUN="$TORUN -jar /server/spigot.jar nogui"

echo "$TORUN $@"
exec $TORUN $@
