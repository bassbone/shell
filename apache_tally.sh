#!/bin/sh

if [ "$1" = "" ]; then
  echo "usage: $0 [access_log] [-hau]"
  exit 0
elif [ ! -f "$1" ]; then
  echo "$1 is not found."
  exit 1
fi

if [ "$2" = "-h" ]; then # per hour
  cat $1|awk '{print $4}'|cut -c14-15|awk '{print $1 "時"}'|sort|uniq -c
  exit 0
elif [ "$2" = "-a" ]; then # per IP address 
  cat $1|awk '{print $1}'|sort|uniq -c|sort -nr
  exit 0
elif [ "$2" = "-u" ]; then # per URI
  cat $1|awk '{print $7}'|sort|uniq -c|sort -nr
elif [ "$2" = "-u1" ]; then # per URI 1st hierarchy
  cat $1|awk '{print $7}'|sed -E "s/(\/.*?)\/.*$/\1/"|sort|uniq -c|sort -nr
elif [ "$2" = "-u2" ]; then # per URI 2nd hierarchy
  cat $1|awk '{print $7}'|sed -E "s/(\/.*?)(\/.*?)\/.*$/\1\2/g"|sed -E "s/(\/.*)\/$/\1/g"|sort|uniq -c|sort -nr
else
  echo "usage: $0 [access_log] [-hau]"
  exit 0
fi

exit 0


