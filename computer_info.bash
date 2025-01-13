
#!/bin/bash
#Skapat av Omar Farouq Salloum och Lowe Göth, grupp 14

echo
echo "Compuer name: $(hostname)"
echo
echo "OS Description: $(cat /etc/os-release | grep -w PRETTY_NAME | cut -d \" -f 2)"
echo "Linux kernal: $(uname -r)"
echo "CPU: $(lscpu | tr -s ' ' | grep -w 'Model name' | cut -d ':' -f 2 | head -n 1)"
echo "Total memory: $(free -h | tr -s ' ' | grep Mem | cut -d ' ' -f 2)"
echo "Free disk space: $(df -h | tr -s ' ' | sed -n 3p | cut -d ' ' -f 4-5)"
echo "IP-address: $(ip addr | grep inet | sed -n 3p | tr -s ' ' | cut -d ' ' -f 3 | cut -d / -f 1)"
echo
