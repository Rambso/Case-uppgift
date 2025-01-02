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
			echo
			echo "		GROUPS"
			echo "---------------------------------------------"
			getent group | awk -F: '$3 >= 1000' | cut -d ":" -f 1 | column -c 50
			echo "---------------------------------------------"
			bash exit.bash
			;;
		v | V)
			clear
			read -p "Name of group: " group
			gid=$(getent group $group | cut -d ":" -f 3)
			echo "Users in $group:"
			echo
			getent group $group | cut -d ":" -f 4 | tr "," "\n"
			cat /etc/passwd | grep $gid | cut -d ":" -f 1
			echo
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
			read -p "Group name: " name
			GID=$(getent group $name | cut -d ":" -f 3)
			if [[ $GID -gt 1000 ]]; then
				delgroup $name
				echo "Group $name has been removed."
			else
				echo "$name is not a user owned group."
			fi
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

