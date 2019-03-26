#!/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "need root"
	exit
fi

apt install nodejs -y
apt install python-gi -y
cp winunix-randr /usr/bin/
cp winunix-randr-gtk /usr/bin/

cat /etc/passwd | grep -v "syslog\|cups" | grep "/home/" | cut -d ":" -f6 > /tmp/foldusers
echo "/etc/skel" >> /tmp/foldusers
while IFS= read -r line; do
	hotKeys="$line/.config/openbox/lubuntu-rc.xml"
	hasHotKey=$(grep "winunix-randr-gtk" $hotKeys | wc -l)
	if [ ! "$hasHotKey" -gt "0" ]; then
		sed -i 's#<keyboard>#<keyboard>\n<keybind key="W-P"><action name="Execute"><command>winunix-randr-gtk</command></action></keybind>#g' $hotKeys
		chmod 777 $hotKeys
	fi
done < /tmp/foldusers