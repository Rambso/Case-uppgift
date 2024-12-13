#!/bin/bash

count=$(ps -ef | grep nano | wc -l)
count=$((count-3))

ps -ef | grep nano | tr -s " " | cut -d " " -f 9 | head -n $count | while read line ; do echo "Öppnat: $line" ; done
