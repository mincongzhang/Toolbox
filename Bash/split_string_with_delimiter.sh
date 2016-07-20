mystring="192.168.1.1,UPDOWN,Line protocol on Interface GigabitEthernet1/0/13, changed state to up"

IFS=',' read -a myarray <<< "$mystring"

echo "IP: ${myarray[0]}"
echo "STATUS: ${myarray[3]}"
