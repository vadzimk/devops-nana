#!/bin/bash
IFS_OLD=$IFS
IFS=$'\n'
read -p "how to sort: mem or cpu ?" how
if [ $how = "mem" ]
then
	how="size"
fi
processes=($(ps aux --sort="$how")) # create an array
# num_lines=$(echo "$processes" | wc -l)
# echo "number of lines $num_lines"
for line in "${processes[@]:1}" # skip the first item of the array
do
	echo "$line" | grep "^$USER"
done
IFS=$IFS_OLD
