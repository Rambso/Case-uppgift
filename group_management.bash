#!/bin/bash

while true; do
	clear
	bash menu.bash group
	read -p "Input: " input

	case $input in
		a | A)
			clear
			echo Aa
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
			clear
			echo Mm
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

