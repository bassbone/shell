#!/bin/sh

if [ "$1" = "" ]; then
  echo "usage: $0 [access_log] [-h]"
  exit 0
elif [ ! -f "$1" ]; then
  echo "$1 is not found."
  exit 1
fi

if [ "$2" = "-h" ]; then
  cat $1|awk '{print $4}'|cut -c14-15|sort|uniq -c
  exit 0
elif [ "$2" = "-a" ]; then
  cat $1|awk '{print $1}'|sort|uniq -c|sort -r
  exit 0
else
  echo "usage: $0 [access_log] [-h]"
  exit 0
fi

exit 0


