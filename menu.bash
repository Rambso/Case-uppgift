#!/bin/bash


case $1 in
	start)
		echo
		echo " ------- SYSTEM MANAGER -------"
		echo
		echo "- c Computer information"
		echo "- g Group management"
		echo "- u User management"
		echo "- f Folder management"
		echo
		echo "- e Exit program"
		echo "------------------------------"
		;;

	user)
		echo "------- USER MANAGEMENT -------"
		echo
		echo "- a Add user"
		echo "- l List users"
		echo "- v View"
		echo "- m Modify user properties"
		echo "- d Delete a login user"
		echo "- e Exit"
		;;
	group)
		echo
		echo "------- Group manager -------"
		echo
		echo "- a Add new group"
		echo "- l List all groups"
		echo "- v View users of a group"
		echo "- m Modify users in group (add or remove)"
		echo "- d Delete group"
		echo "- e Exit"
		echo
		echo "-----------------------------"
		echo
		;;

esac
