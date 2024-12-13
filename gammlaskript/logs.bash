#!/bin/bash
cd $HOME
mkdir Logs
cp /var/log/*.log Logs
echo "-----"
tar czvf Logs/logs.tar.gz Logs
rm Logs/*.log
echo "-----"
ls  Logs

