#!/bin/bash

while true; do
	clear
	bash menu.bash user
	read -p "input: " input

	case $input in
		a | A)
			clear
			echo ADDING USER
			echo
			bash exit.bash
			;;
		l | L)
			clear
			echo "Users: "
			cat /etc/passwd | grep /home/ | cut -d ":" -f 1 | column -c 40
			echo
			bash exit.bash
			;;
		v | V)
			clear
			echo view user attributes
			echo
			bash exit.bash
			;;
		m | M)
			echo Modify user properties
			echo
			bash exit.bash
			;;
		*)
			clear
			exit
			;;
	esac
done
