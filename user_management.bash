#!/bin/bash

# Skapat av Omar Farouq Salloum och Lowe Göth, grupp 14

while true; do
	clear
	bash menu.bash user
	read -p "input: " input

	case $input in
		a | A)
			clear
			echo "------- CREATE USER -------"
			echo
			read -p "Username: " name
			if [[ $name == "" ]]; then
				echo "Name cant be empty"
				bash exit.bash
				exit
			fi
			read -p "Password: " password
			if [[ $password == "" ]]; then
				echo "Password cant be empty"
				bash exit.bash
				exit
			fi
			useradd -mp $(openssl passwd -1 $password) $name
			echo "User $name has been created"
			echo
			bash exit.bash
			;;
		l | L)
			clear
			echo
			echo "Users: "
			cat /etc/passwd | grep /home/ | cut -d ":" -f 1 | column -c 40
			echo
			bash exit.bash
			;;
		v | V)
			clear

			echo "Users: "
			cat /etc/passwd | grep /home | cut -d ":" -f 1 | column -c 40
			echo
			read -p "Username: " name

			if [[ $name == "" ]]; then
				echo "Invalid input"
				bash exit.bash
				exit
			fi

			if [[ $(cat /etc/passwd | grep "$name:" | wc -l) == 0 ]]; then
				echo "User, $name, does not exist"
				bash exit.bash
				exit
			fi
			echo "----------------------------"
			echo -n "Username:	"; cat /etc/passwd | grep $name | cut -d ":" -f 1
			echo -n "Password: 	"; cat /etc/passwd | grep $name | cut -d ":" -f 2
			echo -n "User ID: 	"; cat /etc/passwd | grep $name | cut -d ":" -f 3
			echo -n "Group ID: 	"; cat /etc/passwd | grep $name | cut -d ":" -f 4
			echo -n "Comment: 	"; cat /etc/passwd | grep $name | cut -d ":" -f 5
			echo -n "Directory: 	"; cat /etc/passwd | grep $name | cut -d ":" -f 6
			echo -n "Shell:		"; cat /etc/passwd | grep $name | cut -d ":" -f 7
			echo
			echo -n "Groups: 	"; groups $name | cut -d ":" -f 2 | tr -s " "
			echo
			bash exit.bash
			;;
		m | M)
			clear

			echo "Users: "
			cat /etc/passwd | grep /home | cut -d ":" -f 1 | column -c 40
			echo
			read -p "User to modify: " name
			if [[ $name == "" ]]; then
				echo "Invalid input"
				bash exit.bash
				exit
			fi
			if [[ $( cat /etc/passwd | grep -w $name | wc -l) == 0 ]]; then
				echo "User does not exist"
				bash exit.bash
				exit
			fi 
			clear
			echo "--------- MODIFY USER -------"
			echo "- u Edit username"
			echo "- p Change password"
			echo "- i Edit user id"
			echo "- g Change primary group"
			echo "- c Add comment"
			echo "- d Change home directory"
			echo "- s Change shell"
			echo
			read -p "Input: " input
			case $input in
				u | U)
					read -p "New username: " new_name

					if [[ $new_name == "" ]]; then
						echo "Invalid input"
						bash exit.bash
						exit
					fi
					usermod -l $new_name $name
					;;
				p | P)
					read -p "New password: " password

					if [[ $password == "" ]]; then
						echo "Invalid input"
						bash exit.bash
						exit
					fi
					usermod -p $(openssl passwd -1 $password) $name
					;;
				i | I)
					read -p "New user id: " id

					if [[ $id == "" ]]; then
						echo "Invalid input"
						bash exit.bash
						exit
					fi
					usermod -u $id $name
					;;
				g | G)
					read -p "New group name/id: " group

					if [[ $group == "" ]]; then
						echo "Invalid input"
						bash exit.bash
						exit
					fi
					usermod -g $group $name
					;;
				c | C)
					read -p "Comment: " comment
					usermod -c "$comment" $name
					;;
				d | D)
					read -p "New home directory" dir
					usermod -d /home/$dir $name
					;;
				s | S)
					read -p "Shell: " shell

					if [[ $shell == "" ]]; then
						echo "Invalid input"
						bash exit.bash
						exit
					fi
					usermod -s $shell $name
					;;
				*)
					echo "Invalid input"
			esac

			bash exit.bash
			;;
		d | D)
			clear

			echo "Users: "
			cat /etc/passwd | grep /home | cut -d ":" -f 1 | column -c 40
			echo
			read -p "Name: " name
			if [[ $name == "" ]]; then
				echo "Invalid input"
				bash exit.bash
				exit
			fi
			if [[ $(cat /etc/passwd | grep -w $name | wc -l) == 0 ]]; then
				echo "User, $name,  does not exist"
				bash exit.bash
				exit
			fi
			deluser --remove-all-files $name &> /tmp/usererr.log
			echo
			echo "$name has been removed"
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
