#!/bin/bash

# Skapad av Omar Farouq Salloum och Lowe Göth, Grupp 14
#
# Licens:
#
# Motivering:
#
#

if [[ $UID != 0 ]]; then
	echo "You are not the superuser."
	echo "Use 'sudo' when running script"
	exit
fi

while true; do
	clear
	bash menu.bash start
	read -p "input: " input

	case $input in
		c | C)
			clear
			echo "computer inof"
			bash exit.bash
			;;
		u | U)
			clear
			bash user_management.bash
			bash exit.bash
			;;
		g | G)
			clear
			echo "groups"
			bash exit.bash
			;;
		f | F)
			clear
			echo "filesssssss"
			bash exit.bash
			;;
		e | E)
			clear
			exit
			;;
		*)
			clear
			echo "Invalid input"
			bash exit.bash
			;;
	esac
	#cat /etc/passwd | grep bash # Printar användarkonton
done
