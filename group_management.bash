#!/bin/bash

while true; do
	clear
	bash menu.bash group
	read -p "Input: " input

	case $input in
		a | A)
			clear
			echo -n "Name of group: "
			read name
			rm /tmp/grouperr.log
			addgroup $name 2> /tmp/grouperr.log
			error=$(cat /tmp/grouperr.log | cut -d ":" -f 1)
			if [[ $error == "fatal" ]]; then
				clear
				echo "$name already exists as a group"
			else
				echo "$name has been created"
			fi
			bash exit.bash
			;;
		l | L)
			clear
			echo Ll
			bash exit.bash
			;;
		v | V)
			clear
			echo Vv
			bash exit.bash
			;;
		m | M)
			read -p "User: " user
			read -p "Group: " group
			read -p "(a)dd/(r)emove: " option
			case $option in
				a | A)
					clear
					echo "" > /tmp/grouperr.log
					usermod -aG $group $user 2> /tmp/grouperr.log
					echo "$user has been added to $group"
					;;
				r | R)
					clear
					usermod -rG $group $user
					echo "$user has been removed from $group"
					;;
				*)
					echo "Invalid option"
					;;
			esac
			bash exit.bash
			;;
		d | D)
			clear
			echo Dd
			bash exit.bash
			;;
		e | E)
			clear
			exit
			;;
		*)
			clear
			echo Please enter a valid option
			bash exit.bash
			;;

	esac
done

