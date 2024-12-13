#!/bin/bash

text=`ls /home/lowegoth/Thing | grep -c ".txt$"`
bash=`ls /home/lowegoth/Thing | grep -c ".bash$"`

if [[ $text > $bash ]]; then
	echo "More textfiles"
elif [[ $text < $bash ]]; then
	echo "More Bashfiles"
else
	echo "Equal bashfiles to textfiles"

fi
