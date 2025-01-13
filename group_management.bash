#!/bin/bash

# Skapat av Omar Farouq Salloum och Lowe Göth, grupp 14

while true; do
	clear
	bash menu.bash group
	read -p "Input: " input

	case $input in
		a | A)
			clear
			getent group | awk -F: '$3 >= 1000' | cut -d ":" -f 1 | column -c 50
			echo -n "Name of group: "
			read name
			if [[ $name == "" ]]; then
				echo "Invalid input"
				bash exit.bash
				exit
			fi
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
			getent group | awk -F: '$3 >= 1000' | cut -d ":" -f 1 | column -c 50
			read -p "Name of group: " group
			if [[ $group == "" ]]; then
				echo "Invalid input"
				bash exit.bash
				exit
			fi
			if [[ $(getent group $group | wc -l) == 0 ]]; then
				echo "Group does not exist"
				bash exit.bash
				exit
			fi

			gid=$(getent group $group | cut -d ":" -f 3)
			echo "Users in $group:"
			echo
			getent group $group | cut -d ":" -f 4 | tr "," "\n"
			cat /etc/passwd | grep $gid | cut -d ":" -f 1
			echo
			bash exit.bash
			;;
		m | M)
			clear
			echo "Users: "
			cat /etc/passwd | grep /home | cut -d ":" -f 1 | column -c 45
			echo
			read -p "User: " user
			echo
			echo "Groups: "
			getent group | awk -F: '$3 >= 1000' | cut -d ":" -f 1 | column -c 50
			echo
			read -p "Group: " group
			read -p "(a)dd/(r)emove: " option
			case $option in
				a | A)
					clear
					if [[ $(cat /etc/passwd | grep "$user:" | wc -l) == 0 ]]; then
						echo "User, $user, does not exist"
						bash exit.bash
						exit
					fi
					if [[ $(cat /etc/group | grep "$group:" | wc -l) == 0 ]]; then
						echo "Group, $group, does not exist"
						bash exit.bash
						exit
					fi
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
			getent group | awk -F: '$3 >= 1000' | cut -d ":" -f 1 | column -c 50
			read -p "Group name: " name
			if [[ $name == "" ]]; then
				echo "invalid input"
				bash exit.bash
				exit
			fi
			if [[ $(cat /etc/group | grep -w $name | wc -l) == 0 ]]; then
				echo "Group, $name, does not exist"
				bash exit.bash
				exit
			fi
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

