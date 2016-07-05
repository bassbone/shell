#!/bin/sh

yum check-update|egrep "(updates)|(base)"|grep -v "*"|cut -d" " -f1|sed -e "s/\.i386//g"|sed -e "s/\.x86_64//g"|sed -e "s/\.noarch//g"|sed -e "s/\.i686//g"|sort|uniq|xargs

exit 0;

