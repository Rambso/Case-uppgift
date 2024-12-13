#!/bin/bash

# Skapad av Omar Farouq Salloum och Lowe Göth, Grupp 14
#
# Licens:
#
# Motivering:
#
#

while true; do
	clear
	bash menu.bash
	read -p "input: " input
	echo $input

	case $input in
		c | C)
			clear
			echo "computer inof"
			bash exit.bash
			;;
		u | U)
			clear
			echo "Users"
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
