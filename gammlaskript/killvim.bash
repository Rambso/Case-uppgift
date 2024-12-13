#!/bin/bash

count=$(ps -ef | grep vim | wc -l)
count=$((count-2))

ps -ef | grep vim | tr -s " " | cut -d " " -f 2 | head -n $count | while read line ; do kill $line ; done
