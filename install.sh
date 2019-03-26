#!/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "need root"
	exit
fi

cp winunix-randr /usr/bin/