#!/bin/bash

echo
echo ------- Home Directories -------
ls /home | column -c 85
echo
read -p "Username: " user
path="/home/$user"
if [[ "$(cat /etc/passwd | grep $user: | wc -l)" == 0 ]]; then
	echo "User does not exist"
	exit
fi

while true; do
	clear
	echo "Current path: $path"
	echo
	ls $path | column -c 85
	echo
	echo "options"
	echo "-c Change directory"
	echo "-b Back"
	echo "-v view"
	echo "-m Modify"
	echo "-a Add"
	echo "-d delete"
	echo "-e exit"
	echo

	read -p "Option: " input

	case $input in
		c | C)
			read -p "input: " dir
			if [[ "$(ls $path | grep $dir | wc -l)" == 0 ]]; then
				echo "folder does not exist"
				exit
			fi
			path="$path/$dir"
			;;
		b | B)
			path="$(dirname $path)" 
			;;
		v | V)
			read -p "input: " folderToView
			if [[ "$(ls $path | grep $folderToView | wc -l)" == 0 ]]; then
				echo "Folder does not exist"
				exit
			fi
			ls -l $path | grep $folderToView
			bash exit.bash
			;;
		m | M)
			bash modify_file.bash $path
			;;
		a | A)
			read -p "new directory name: " name
			mkdir $path/$name
			;;
		d | D)
			read -p "name of directory: " name
			read -p "Are you sure? y/n" choice
			case $choice in
				y | Y) rmdir -p $path/$name ;;
				n | N) exit ;;
			esac ;;
		e | E) exit ;;
	esac
done
