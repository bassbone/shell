#!/bin/sh


if [ "$2" = "-h" ]; then
  cat $1|awk '{print $4}'|cut -c14-15|sort|uniq -c
else
  echo "usage: $0 [access_log] [-h]"
fi

exit


