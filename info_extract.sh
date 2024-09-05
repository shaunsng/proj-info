#!/bin/bash

#~ This script aims to extracts the following info:

#~ 1. Public IP Address
#~ 2. Internal IP of machine
#~ 3. Mac addtopress of Machine(Censor the 1st part)
#~ 4. Display the Top 5 process’s CPU usage
#~ 5. Display Memory Usage, Free and Used
#~ 6. Display you Active system services and status
#~ 7. Display the top 10 files(Size) from the /home directory


echo

# 1. Extracting public ip with curl. -s silent mode to avoid headers.

PUB_IP=$(curl -s ifconfig.me)
echo "Your Public IP is $PUB_IP"

# 2. Extracting Internal IP

INT_IP=$(ifconfig | grep broadcast | awk '{print$2}')
echo "Your Internal IP is $INT_IP"

# 3. Extracting mac_address
  
MAC_ADD=$(ifconfig | grep ether | awk '{print$2}')
echo "Your MAC address is $MAC_ADD"

#~ 4. Display the Top 5 process’s CPU usage

echo
echo "The top 5 processes by CPU usage in your machine are:" 

ps -eo pid,comm,pcpu --sort -pcpu | head -6

#~ 5. Display Memory Usage, Free and Used

echo

MEM_TOTAL=$(free -m | grep Mem | awk '{print$2}')
MEM_USED=$(free -m | grep Mem | awk '{print$3}')
MEM_FREE=$(free -m | grep Mem | awk '{print$4}')

echo "Your machine has total $MEM_TOTAL MB of memory"
echo "You are using $MEM_USED MB memory."
echo "There is $MEM_FREE MB free memory left."


#~ 6. Display you Active system services and status
echo 
echo "The active services in your machine are:"
echo

service --status-all | grep +

# systemctl list-units --type=;lsservice --state=active


#~ 7. Display the top 10 files(Size) from the /home directory

echo
echo "The top 10 file by size in your /home directory are:"

cd
# du -hs * | sort -rh | head -10

ls -lSAh | head  -11 | awk '{print$5,$9}'

echo
echo "The script has completed. Have a nice day."
