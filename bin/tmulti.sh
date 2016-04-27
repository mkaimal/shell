#!/bin/bash 
#
# __mkaimal__

checktmux()
{
	tmux list-session 
	if [ $? -eq 0 ]
	then 
		tsession_name=$(tmux list-session  | awk 'NR==1{print $1}'| cut -d: -f1)

	else 
		tsession_name=tmulti 
		tmux new-session -d -s tmulti
	fi
}

startmux()
{
	checktmux

	if [ $@ -eq 0 ]
	then
	 echo '	usage()' 
	else 
		tmux attach-session -t $tsession_name
		for h in $# 
		do 
			tmux split-window -h " ssh $h" 
			tmux select-layout tiled > /dev/null 
		done
		tmux select-page -t 0 
		tmux set-window-option synchronize-panes on > /dev/null
	fi
}

startmux
