#!/bin/bash

if [[ `apt list $1 | grep -c installed` == 0 ]] 
then
	echo "Installing $1"
	sudo apt dist-upgrade
	sudo apt install $1
fi


echo "$1 installed"
echo "Running $2 processes of $1 for $3 seconds in xterm"

for ((i = 0; i < $2; i++ ));
do
	xterm $1 &
	#kör programmet i ett xtrem-fönster som bakgrundsprocess
done

sleep $3

killall xterm
#döda alla xterm-processer

echo -n "Unistall $1? (y/n)"
read val

if [[ "$val" == "y" ]]
then
	echo "Unistalling $1"
	#avinstallera $1
	sudo apt remove $1
fi  
