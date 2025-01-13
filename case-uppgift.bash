#!/bin/bash

# Skapad av Omar Farouq Salloum och Lowe Göth, Grupp 14
#
# Licens: MIT License
#
#
# Copyright 2025 Omar och Lowe
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation 
# files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, 
# modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software 
# is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR 
# ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
#
# Motivering: Vi har valt att anända MIT license för att den låter alla att använda, modifiera och dela ut scriptet hur de vill. 
#
#

if [[ $UID != 0 ]]; then
	echo "You are not the superuser."
	echo "Use 'sudo' when running script"
	exit
fi

while true; do
	clear
	bash menu.bash start
	read -p "input: " input

	case $input in
		c | C)
			clear
			bash computer_info.bash
			bash exit.bash
			;;
		u | U)
			clear
			bash user_management.bash
			;;
		g | G)
			clear
			bash group_management.bash
			;;
		f | F)
			clear
			bash file_management.bash
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
