#!/bin/sh

if [ "$1" == "" ]; then
  echo "usage: $0 [self IP address]"
  exit 1
fi

echo "*** nmap ***"
nmap localhost
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

