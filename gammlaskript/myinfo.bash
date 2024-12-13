
#!/bin/bash

Version=$(lsb_release -a)

for INPUT in $@; do

	if [[ $INPUT == "-a" ]]; then
	echo -n "Linux version: "
	echo $Version | cut -d ':' -f 3 | cut -c 1-20

	echo -n "IP Adress: "
	ip -f inet addr | grep inet | cut -c 10-21 | tail -n 1

	echo -n "MAC address "
	cat /sys/class/net/enp0s3/address
	fi
	if [[ $INPUT == "-p" ]]; then
	echo "Number of installed packages: "; apt list | wc -l
	fi

	if [[ $INPUT == "--help" ]]; then
	echo "Usage: myinfo.bash OPTION..."
	echo "Print out system information"
	echo "OPTIONS"
	echo "-a, --all display all information"
	echo "-v, --version display linux version"
	echo "-i, --ip display IP address"
	echo "-m, --mac display MAC address"
	echo "--help display this help and exit"
	fi

	if [[ $INPUT == "-v" ]]; then
	echo -n "Linux version: "
	echo $Version | cut -d ':' -f 3 | cut -c 1-20
	fi

	if [[ $INPUT == "-i" ]]; then
	echo -n "IP Adress: "
	ip -f inet addr | grep inet | cut -c 10-21 | tail -n 1
	fi

	if [[ $INPUT == "-m" ]]; then
	echo -n "MAC address: "
	cat /sys/class/net/enp0s3/address
	fi
done
