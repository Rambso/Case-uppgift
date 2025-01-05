#!/bin/bash

# Skapad av Omar Farouq Salloum och Lowe Göth, Grupp 14
#
# Licens: MIT License
#
# Motivering: Vi tycker att 
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
			bash computer_info.bash
			bash exit.bash
			;;
		u | U)
			clear
			bash user_management.bash
			;;
		g | G)
			clear
			bash group_management.bash
			;;
		f | F)
			clear
			bash file_management.bash
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

done
