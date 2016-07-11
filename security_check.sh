#!/bin/sh

echo "*** nmap ***"
nmap localhost
echo ""

echo "*** lastlog ***"
lastlog|grep -v "Never"
echo ""

echo "*** yum update check ***"
yum check-update
echo ""

