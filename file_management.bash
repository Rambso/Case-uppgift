#!/bin/bash
clear
echo
echo ------- Home Directories -------
ls /home | column -c 85
echo
read -p "Username: " user
if [[ $user == "" ]]; then
	echo "No user selected"
	exit
fi
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
			if [[ $dir == "" ]]; then
				echo "Invalid input"
				bash exit.bash
				exit
			fi
			if [[ "$(ls $path | grep -w $dir | wc -l)" == 0 ]]; then
				echo "folder does not exist"
				exit
			fi
			path="$path/$dir"
			;;
		b | B)
			path="$(dirname $path)" 
			;;
		v | V)
			echo
			read -p "input: " folderToView
			if [[ $folderToView == "" ]]; then
				echo "Invalid input"
				bash exit.bash
				exit
			fi
			if [[ "$(ls $path | grep -w $folderToView | wc -l)" == 0 ]]; then
				echo "Folder does not exist"
				exit
			fi
			clear
			echo "Viewing $folderToView"
			echo
			echo "Atributes"
			echo "owner ($(ls -l $path | grep -w $folderToView | tr -s ' ' | cut -d ' ' -f 3)):"
			for ((i = 2 ; i <= 4 ; i++ )); do
				case $(ls -l $path | grep -w $folderToView | tr -s ' ' | cut -b $i) in
					r) echo "	Reading permission" ;;
					w) echo "	Wrting permission" ;;
					x) echo "	Execute permission" ;;
					s | S) echo "	Setuid, will execute with owner permissions" ;;
				esac
			done
			echo "Group ($(ls -l $path | grep -w $folderToView | tr -s ' ' | cut -d ' ' -f 4)):"
			for ((i = 5 ; i <= 7 ; i++ )); do
				case $(ls -l $path | grep -w $folderToView | tr -s ' ' | cut -b $i) in
					r) echo "	reading permission" ;;
					w) echo "	writing permission" ;;
					x) echo "	execte permission" ;;
					s | S) echo "	Setgid, will execute with group permission" ;;
				esac
			done
			echo "Other: "
			for ((i = 8 ; i <= 10 ; i++ )); do
				case $(ls -l $path | grep -w $folderToView | tr -s ' ' | cut -b $i) in
					r) echo "	reading permissions" ;;
					w) echo "	Writing permissions" ;;
					x) echo "	execute permission" ;;
					t) echo " 	Stickybit, files may only be removed by owner" ;;
				esac
			done
			echo "Last modified: $(ls -l $path | grep -w $folderToView | tr -s ' ' | cut -d ' ' -f 6-8)"
			bash exit.bash
			;;
		m | M)
			bash modify_file.bash $path
			;;
		a | A)
			read -p "Name of new directory: " name
			if [[ $name == "" ]]; then
				echo "Name cant be empty"
				bash exit.bash
				exit
			fi
			mkdir $path/$name
			gid=$(cat /etc/passwd | grep $user | cut ":"-f 4)
			chown $user:$(cat /etc/group | grep -w $gid | cut -d ':' -f 1)  $path/$name
			;;
		d | D)
			echo $path
			read -p "Name of the directory you wish to remove: " name
			if [[ $name == "" ]]; then
				echo "Invalid input"
				exit
			fi 
			if [[ $(ls $path | grep -w $name | wc -l) == 0 ]]; then
				echo "directory does not exist"
				exit
			fi
			read -p "Are you sure? (y/n): " choice
			case $choice in
				y | Y) rm -rf $path/$name ;;
				n | N) exit ;;
			esac ;;
		e | E)
			exit ;;
	esac
done
