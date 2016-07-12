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
last|grep -v "system boot"|grep -v "$1"
echo ""

echo "*** yum update check ***"
yum check-update
echo ""

echo "*** iptables ***"
iptables -L
echo ""
