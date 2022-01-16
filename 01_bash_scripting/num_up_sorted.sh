#!/bin/bash
read -p "how to sort: mem or cpu ?" how
read -p "how many lines to print?" num_lines_print
if [ $how = "mem" ]
then
	how="size"
fi

ps aux --sort="$how" --no-headers | grep "^$USER" | head -n "$num_lines_print" /dev/stdin
