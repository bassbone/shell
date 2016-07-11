#!/bin/sh

echo "*** nmap ***"
nmap localhost
echo ""

echo "*** lastlog ***"
lastlog|grep -v "Never"
echo ""

echo "*** last ***"
last|tail -10
echo ""

echo "*** yum update check ***"
yum check-update
echo ""

