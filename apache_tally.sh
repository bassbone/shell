#!/bin/sh

if [ "$1" = "" ]; then
  echo "usage: $0 [access_log] -[h|m|a|u|u1|u2|s|rh] [filter]"
  exit 0
elif [ ! -f "$1" ]; then
  echo "$1 is not found."
  exit 1
fi

if [ "$2" = "-h" ]; then # per hour
  cat $1|grep "$3"|awk '{print $4}'|cut -c14-15|awk '{print $1 "時"}'|sort|uniq -c
elif [ "$2" = "-m" ]; then # per minute
  cat $1|grep "$3"|awk '{print $4}'|cut -c14-18|sort|uniq -c
elif [ "$2" = "-a" ]; then # per IP address 
  cat $1|grep "$3"|awk '{print $1}'|sort|uniq -c|sort -nr
elif [ "$2" = "-u" ]; then # per URI
  cat $1|grep "$3"|awk '{print $7}'|sort|uniq -c|sort -nr
elif [ "$2" = "-u1" ]; then # per URI 1st hierarchy
  cat $1|grep "$3"|awk '{print $7}'|sed "s/?.*$//g"|sed -r "s/(\/[^\/]*)\/.*$/\1/g"|sort|uniq -c|sort -nr
elif [ "$2" = "-u2" ]; then # per URI 2nd hierarchy
  cat $1|grep "$3"|awk '{print $7}'|sed "s/?.*$//g"|sed -r "s/(\/[^\/]*)(\/[^\/]*)\/.*$/\1\2/g"|sort|uniq -c|sort -nr
elif [ "$2" = "-s" ]; then # per status code
  cat $1|grep "$3"|awk '{print $9}'|sort|uniq -c
elif [ "$2" = "-rh" ]; then # per referer host
  cat $1|grep "$3"|awk '{print $11}'|sed -r "s/^.*\/\/([^\/]*).*$/\1/"|sort|uniq -c|sort -nr
else
  echo "usage: $0 [access_log] -[h|m|a|u|u1|u2|s|rh] [filter]"
fi

exit 0


