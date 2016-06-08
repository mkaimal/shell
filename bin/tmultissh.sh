#!/bin/bash

# script to start multiple ssh session on exisiting or new tmux session 
# if tmux session exisits, join to the session or start new session. 


usage()
{
cat << EOF
usage : $0  <host1> <host2> 

EOF
}


if [ $# -eq 0 ] 
then 
	usage 
else 
	tmux new-session -d -s multissh
	for i in $*
	do
	tmux split-window -h  " ssh $i "
	tmux select-layout tiled   > /dev/null	 
	done
	tmux kill-pane -t 0
	tmux rename-window ${i}-MC
	tmux attach  -t multissh

fi
 
