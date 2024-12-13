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

esac
