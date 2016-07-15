#!/bin/sh

if [ "$1" == "" ]; then
  echo "usage: $0 [self IP address]"
  exit 1
fi

echo "*** nmap ***"
nmap -sT -sU -p 0-65535 localhost|grep "open"
echo ""

echo "*** lastlog ***"
lastlog|grep -v "Never"
echo ""

echo "*** last ***"
exclude_address=`echo "$1"|sed 's/,/\\|/g'`
last|grep -v "system boot\|wtmp"|grep -v "$exclude_address"
echo ""

echo "*** yum update check ***"
yum check-update|grep -v "^Loaded plugins:"
echo ""

echo "*** iptables ***"
iptables -L|grep -v "^$"
echo ""

echo "*** crontab ***"
crontab -l
echo ""
cat /etc/crontab|grep -v "^$"|grep -v "^#"|grep -v "^[A-Z]"
echo ""

echo "*** chkconfig ***"
chkconfig --list|grep 3:on|grep -v "^network"|grep -v "^iptables"|grep -v "^sshd"|grep -v "^ntpd"|grep -v "^crond"
echo ""

echo "*** root login ***"
ls -l /etc/securetty
echo ""

echo "*** sshd_config ***"
cat /etc/ssh/sshd_config|grep -v "^#"|grep -v "^$"|grep -v "^AcceptEnv"
echo ""

echo "*** suoders ***"
cat /etc/sudoers|grep -v "^#"|grep -v "Defaults"|grep "ALL"
echo ""

echo "*** /usr/bin ***"
find /usr/bin/ -type f -mtime -30
echo ""

echo "*** /usr/bin SUID ***"
find /usr/bin -user root -perm -4000 -print
echo ""

echo "*** /usr/bin SGID ***"
find /usr/bin -user root -perm -2000 -print
echo ""

echo "*** /etc/hosts ***"
cat /etc/hosts
echo ""

echo "*** who ***"
who|grep -v "$1"
echo ""

