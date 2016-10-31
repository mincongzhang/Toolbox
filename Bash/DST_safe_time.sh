#change Dublin 9:00 to EST time, out put should be 0500 in winter, 0400 in summer time
date --date='TZ="/usr/share/zoneinfo/Europe/Dublin" 09:00' +%H%M
