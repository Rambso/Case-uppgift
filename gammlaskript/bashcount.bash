#!/bin/bash

count=$(ps -ef | grep bash | wc -l)
count=$((count-2))
echo Just nu körs $count instanser av bash.
