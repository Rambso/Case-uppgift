#!/bin/bash

path=$1
clear
echo "Current path: $path"
echo
ls $path | column -c 85
echo
read -p "File to modify: " file

if [[ $(ls $path | grep -w "$file" | wc -l) == 0 ]]; then
	echo "File, $file, not in this directory"
	bash exit.bash
	exit
fi

clear
echo
echo "Modifying $file"
echo
echo "Options: "
echo "- p Permissions"
echo "- o Change owner"
echo "- g Change group"

if [[ "$(ls -l $path | grep $file | cut -c1)" == "d" ]]; then
	echo "- t Sticky bit (files may only be removed by the owner)"
else
	echo "- ui SETUID, execute file witth owner permissions"
	echo "- gi SETGID, execute file with group permissions"
fi

echo
read -p "Option: " input

case $input in
	p | P)
		clear
		echo "Changing permssions for $file"
		echo
		echo "Options: "
		echo "- a Manage permissions of All"
		echo "- u Manage permissions of owner"
		echo "- g Manage permissions of group"
		echo "- o Manage permissions of other"
		echo
		read -p "Option: " opt
		case $opt in
			a | A)
				opt="ugo"
				pEdit="All"
				;;
			u | U)
				opt="u"
				pEdit="Owner"
				;;
			g | G)
				opt="g"
				pEdit="Group"
				;;
			o | O)
				opt="o"
				pEdit="Other"
				;;
			*)
				echo "Invalid input"
				bash exit.bash
				exit
				;;
		esac
		echo
		echo "Permissions"
		echo "- r Read"
		echo "- w Write"
		echo "- x Execute"
		echo
		read -p "Which permission would you like to modify: " permission
		case $permission in
			r | R)
				perm="read"
				permission="r"
				;;
			w | W)
				perm="write"
				permission="w"
				;;
			x | X)
				perm="execute"
				permission="x"
				;;
			*)
				echo "Invalid input"
				bash exit.bash
				exit
				;;
		esac
		read -p "Do you want to add(a) or remove(r) permissions?: " action
		case $action in
			a | A)
				chmod $opt+$permission $path/$file
				echo "$perm permissions added to $pEdit"
				bash exit.bash
				exit
				;;
			r | R)
				chmod $opt-$permission $path/$file
				echo "$perm permissions removed from $pEdit"
				bash exit.bash
				exit
				;;
		esac
		;;
	o | O)
		read -p "New owner: " name
		if [[ $(cat /etc/passwd | grep "$name:" | wc -l) != 0 ]]; then
			chown $name $path/$file
			echo "Owner of $file is now $name"
			bash exit.bash
			exit
		else
			echo "No such user exists"
			bash exit.bash
			exit
		fi
		;;
	g | G)
		read -p "New file group: " group
		if [[ $(cat /etc/group | grep "$group:" | wc -l) != 0 ]]; then
			chgrp $group $path/$file
			echo "Group ownership of $file now belongs to $group"
			bash exit.bash
			exit
		else
			echo "Group, $group, does not exist"
			bash exit.bash
			exit
		fi
		;;
	t | T)
		chmod o+t $path/$file
		echo
		echo "Sticky bit enabled. Users can only remove files they own"
		bash exit.bash
		exit
		;;
	ui | UI)
		chmod u+s $path/$file
		echo "File will execute with owner permissions"
		echo
		bash exit.bash
		exit
		;;
	gi | GI)
		chmod g+s $path/$file
		echo "File will execute with group permissions"
		echo
		bash exit.bash
		exit
		;;
	*)
		clear
		echo "Invalid option"
		bash exit.bash
		exit
		;;
esac
