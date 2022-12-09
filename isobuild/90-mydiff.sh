#!/bin/bash
#
# Usage: $0 firstfile secondfile
#

while IFS= read -r line
do
    #echo "$line"
    pattern=`echo "$line" | awk '{print $1}'`
    #echo $pattern
    if [[ $(grep -q "$pattern" "$2") -ne 0 ]]; then
      echo $line
    fi
done < "$1"
