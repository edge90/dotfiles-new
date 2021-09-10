#!/bin/fish

set host (ssh-list.sh | dmenu --bottom --prompt "Ssh to:")

if test $status -eq 0
    alacritty --command fish -C "ssh $host"
else
    exit 1
end
