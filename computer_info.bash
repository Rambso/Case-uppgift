
#!/bin/bash

echo
echo "Compuer name: $(hostname)" 
echo "OS Description: $(uname -a | cut -d ' ' -f 3)"
echo "Linux kernal: $(uname -r)"
echo "CPU: $(lscpu | tr -s ' ' | grep name | cut -d ' ' -f 3-8)"
echo "Total memory: $(free -h | tr -s ' ' | grep Mem | cut -d ' ' -f 4)"
echo "Free disk space: $(df -h | tr -s ' ' | sed -n 3p | cut -d ' ' -f 4-5)"
echo "IP-address: $(ip addr | grep inet | sed -n 3p | tr -s ' ' | cut -d ' ' -f 3 | cut -d / -f 1)"
echo
