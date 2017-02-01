#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "$0 percentage length"
  exit 1
fi

percentage=$1
length=$2

if [[ $(echo "$percentage > 100" | bc) = 1 || $(echo "$percentage < 0" | bc) = 1 ]]
then
  echo "percentage should be between 0 and 100"
  exit 1
fi

echo -n "["
filled_length=$( echo "$percentage * $length/ 100" | bc)
for ((i=0; i<$filled_length; i++))
do
  echo -n "#"
done

for ((i=$filled_length; i<$length; i++))
do
  echo -n " "
done

#Remove trailing and leading zeros
percentage=$(echo $1 | sed '/\./ s/\.\{0,1\}0\{1,\}$//' | sed 's/^0*\([1-9]\)/\1/')
#Print normalized to two significant decimals
echo "] ($(echo "scale=2; $percentage / 1" | bc)%)"





