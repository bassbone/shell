#!/bin/sh

if [ "$1" == "" ]; then
  echo "usage: $0 [self IP address]"
  exit 1
fi

echo "*** nmap ***"
nmap localhost|grep "open"
echo ""

echo "*** lastlog ***"
lastlog|grep -v "Never"
echo ""

echo "*** last ***"
exclude_address=`echo "$1"|sed 's/,/\\|/g'`
last|grep -v "system boot\|wtmp"|grep -v "$exclude_address"
echo ""

echo "*** yum update check ***"
yum check-update
echo ""

echo "*** iptables ***"
iptables -L
echo ""

echo "*** crontab ***"
crontab -l
echo ""
cat /etc/crontab|grep -v "^#"
echo ""

echo "*** chkconfig ***"
chkconfig --list|grep 3:on|grep -v "^network"|grep -v "^iptables"
echo ""

echo "*** root login ***"
ls -l /etc/securetty
echo ""

echo "*** sshd_config ***"
cat /etc/ssh/sshd_config|grep -v "^#"|grep -v "^$"
echo ""

echo "*** suoders ***"
cat /etc/sudoers|grep -v "^#"|grep -v "Defaults"|grep "ALL"
echo ""

