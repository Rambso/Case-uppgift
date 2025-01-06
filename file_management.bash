
#!/bin/bash
ls /home | column -c 85
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
			echo "Permissions"
			echo "Owner ($(ls -l $path | grep $folderToView | tr -s ' ' | cut -d ' ' -f 3)):"
			if [[ "$(ls -l $path | grep $folderToView | tr -s ' ' | cut -b 2 )" == r ]]; then
				echo "     Reading permission"
			fi
			echo "     Permission goes here"
			echo "     Permission goes here"
			echo "Group:"
			echo "Other:"
			echo
			echo "Last modified: $(ls -l $path | grep $folderToView | tr -s ' ' | cut -d ' ' -f 6-8)"
			bash exit.bash
			;;
		m | M) 
			read -p "What file? " fileInput
			if [[  "$(ls $path | grep $fileInput | wc -l)" == 0 ]]; then
				echo "Folder does not exist"
				exit
			fi
			echo "-p Permissions"
			echo "-o Owner"
			echo "-g Group"
			
			read -p "What do you want to change?" changeInput
			case $changeInput in
				p | P)
					;;
				o | O)
					compgen -u | column -c 85
					read -p "Which user?" userInput
					if [[ "$(compgen -u | grep $userInput)" == 0 ]]; then
						echo "user does not exist"
						exit
					fi
					chown -c $userInput $fileInput
					;;
				g | G)
					compgen -g | column -c 85
					read -p "Which group? " groupInput
					if [[ "$(compgen -u | grep $groupInput)" == 0 ]]; then
						echo "Group does not exist"
						exit
					fi
					chown -c :$groupInput $fileInput
					;;
			esac
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
