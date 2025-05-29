#!/usr/bin/env bash
## 2025 Douglas@RedSiege.com
## Organize Masscan results
## Use at your own risk.
##
declare -A protos ## Declare an associative array
## These are in order by port number
## When adding ports, add them in the correct place
protos["ftp"]=21
protos["ssh"]=22
protos["telnet"]=23
protos["dns"]=53
protos["tftp"]=69
protos["http"]=80
protos["kerb"]=88
protos["pop3"]=110
protos["ntp"]=123
protos["netbios"]=139
protos["snmp"]=161
protos["snmp-trap"]=162
protos["bgp"]=179
protos["ldap"]=389
protos["https"]=443
protos["smb"]=445
protos["kerb-passwd"]=464
protos["ike"]=500
protos["rlogin"]=513
protos["smtp"]=587
protos["ldaps636"]=636
protos["rsync"]=873
protos["pop3s"]=995
protos["mssql"]=1433
protos["oracle"]=1521
protos["cisco-vqp"]=1589
protos["radius"]=1812
protos["nfs"]=2049
protos["cpanel"]=2082
protos["ssh2222"]=2222
protos["ldaps3269"]=3269
protos["mysql"]=3306
protos["rdp"]=3389
protos["cisco-smi"]=4786
protos["radmin"]=4899
protos["voip"]=5060
protos["voips"]=5061
protos["postgres"]=5432
protos["adb"]=5555
protos["redis"]=6389
protos["althttp"]=8080
protos["https8443"]=8443
protos["admgs"]=9389
# protos[""]=
## TODO - Add more above

## Create directory if not already there:
if [ ! -d "protocols" ];then
 mkdir protocols
fi

## Clear out directory:
rm -rf ./protocols/*

## Loop over all files and create proto files in ./protocols
for proto in "${!protos[@]}"; do
 #echo "Proto: $proto, Port: ${protos[$proto]}"
 port=${protos[$proto]}
 readarray -t results < <(masscan --readscan *.masscan | egrep -E "\s$port\/")
 ## Now we have the results array, let's check it's length:
 if [[ ${#results} -gt 1 ]]
  then
  ## lolop over array and place line into corresponding file:
   for line in "${results[@]}"; do
     echo $line|sed -r 's/.*\son\s//g' >> ./protocols/${proto}.txt
     ## remove everything except IP/hostname
   done
 fi
done

## All done :-)
printf "[i] Completed organizing scans into ./protocols\n"
ls -lah ./protocols
