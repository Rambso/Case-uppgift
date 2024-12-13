#!/bin/bash
num=$(echo $PATH | wc -m)
list=$(echo $PATH | sed "s/:/\' \'/")
for VAR in $list; do
if [[ $VAR == " " ]]; then
echo \n
else
echo $VAR
fi
done
