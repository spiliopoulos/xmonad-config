#!/bin/bash

if [ "$#" -ne 3 ]; then
  echo "$0 percentage length decimals"
  exit 1
fi

percentage=$1
length=$2
decimals=$3

if [[ $(echo "$percentage > 100" | bc) = 1 || $(echo "$percentage < 0" | bc) = 1 ]]
then
  echo "percentage should be between 0 and 100"
  exit 1
fi

echo -n "["
echo -n "<fc=#96d870>"
filled_length=$( echo "$percentage * $length/ 100" | bc)
for ((i=0; i<$filled_length; i++))
do
  echo -n "█"
done

semifilled_box=$( echo "(2 * $percentage * $length/ 100) > (2*$filled_length) " | bc)
if [[ $semifilled_box = 1 ]]; then
  filled_length=$(($filled_length + 1))
  echo -n "░"
fi
echo -n "</fc>"



echo -n "<fc=#000000>"
for ((i=$filled_length; i<$length; i++))
do
  echo -n "█"
done
echo -n "</fc>"

#Remove trailing and leading zeros
percentage=$(echo $1 | sed '/\./ s/\.\{0,1\}0\{1,\}$//' | sed 's/^0*\([1-9]\)/\1/')
#Print normalized to two significant decimals
printf "](%3.${decimals}f%%)" "$(echo "scale=$decimals; $percentage / 1" | bc)"

