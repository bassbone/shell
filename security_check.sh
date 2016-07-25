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
crontab -l|grep -v "^no crontab for"
echo ""
cat /etc/crontab|grep -v "^$"|grep -v "^#"|grep -v "^[A-Z]"
echo ""

echo "*** chkconfig ***"
chkconfig --list|grep 3:on|grep -v "^network"|grep -v "^iptables"|grep -v "^sshd"|grep -v "^ntpd"|grep -v "^crond"|grep -v "^rsyslog"|grep -v "^auditd"|grep -v "^atd"|grep -v "^irqbalance" 
echo ""

echo "*** root login ***"
ls -l /etc/securetty
echo ""

echo "*** sshd_config ***"
cat /etc/ssh/sshd_config|grep -v "^#"|grep -v "^$"|grep "^PermitRootLogin"|sed "s/\(PermitRootLogin\s*yes\)/\1 NG!!!/g"
echo ""

echo "*** suoders ***"
cat /etc/sudoers|grep -v "^#"|grep -v "Defaults"|grep "ALL"
echo ""

echo "*** /usr/bin ***"
find /usr/bin/ -type f -mtime -30|xargs
echo ""

echo "*** /usr/bin SUID ***"
find /usr/bin -user root -perm -4000 -print|xargs
echo ""

echo "*** /usr/bin SGID ***"
find /usr/bin -user root -perm -2000 -print|xargs
echo ""

echo "*** /etc/hosts ***"
cat /etc/hosts
echo ""

echo "*** who ***"
who|grep -v "$1"
echo ""

