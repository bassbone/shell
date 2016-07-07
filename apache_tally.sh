#!/bin/sh

cat $1|awk '{print $4}'|cut -c14-15|sort|uniq -c

exit


