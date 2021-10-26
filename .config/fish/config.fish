
########################################
# Greeting
########################################

# Disable default greeting msg
set fish_greeting

########################################
# Environment variables
########################################

set --export PATH $HOME/.local/bin $PATH
set --export SSH_AUTH_SOCK $HOME/.ssh/agent.sock

# Enable waylad (move to .pamenvironment?)
set --export MOZ_ENABLE_WAYLAND 1
set --export GDK_BACKEND wayland

set --export EDITOR nvim
set --export PAGER less

########################################
# Aliases
########################################

# vim
alias vim=$EDITOR
alias vi=$EDITOR
alias e=$EDITOR

# ls
alias l="ls -la"
alias la="ls -a"
alias ll="ls -l"
alias ls="exa --color=always --group-directories-first"
alias lt="ls -T"

# pacman
alias pacman-clean="sudo pacman -Rns (pacman -Qtdq)"
alias pacman-update-mirrorlist="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"

# Confirm
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# Sizes
alias df="df -h"
alias du="du -h"
alias free="free -h"

# ssh
#alias ssh="TERM=xterm-256color command ssh"

########################################
# Function
########################################

# Get latest errors from journalctl
function journalctl-errors
    if not count $argv
        set argv 3
    end

    command journalctl -p$argv -xb
end

function config-cd
    cd $HOME/.config
end

function config-files
    fd --type f --follow . $HOME/.config
end

function config-edit
    set file (config-files | fzf)

    if test $status -eq 0
        vim $file
    else
        return 1
    end
end

function ssh-to
    set file (ssh-list.sh | fzf)

    if test $status -eq 0
        ssh $file
    else
        return 1
    end
end

########################################
# Prompt
########################################
starship init fish | source
fish_vi_key_bindings
