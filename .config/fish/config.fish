
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
#set --export MOZ_ENABLE_WAYLAND 1
#set --export GDK_BACKEND wayland

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

function git-add-file
    set file (git status --short | grep -E '^.[D|M|R|T|\?]' | fzf | awk '{ print $2 }' | xargs echo)

    if test $status -eq 0
        git add $file
    else
        return 1
    end
end

function git-restore-file
    set file (git status --short | grep -E '^[A|D|M|R|T]' | fzf | awk '{ print $2 }' | xargs echo)

    if test $status -eq 0
        git restore --staged $file
    else
        return 1
    end
end

########################################
# Prompt
########################################
starship init fish | source
fish_vi_key_bindings

# git add
bind --mode default \cg\ca 'git-add-file; commandline -f repaint'
bind --mode default ga 'git-add-file; commandline -f repaint'
bind --mode insert \cg\ca 'git-add-file; commandline -f repaint'

# git commit
bind --mode default \cg\cc 'git commit; commandline -f repaint'
bind --mode default ga 'git commit; commandline -f repaint'
bind --mode insert \cg\cc 'git commit; commandline -f repaint'

# git diff
bind --mode default \cg\cd 'git diff; commandline -f repaint'
bind --mode default gd 'git diff; commandline -f repaint'
bind --mode insert \cg\cd 'git diff; commandline -f repaint'

# git log
bind --mode default \cg\cl 'git log; commandline -f repaint'
bind --mode default gl 'git log; commandline -f repaint'
bind --mode insert \cg\cl 'git log; commandline -f repaint'

# git push
bind --mode default \cg\cp 'git push; commandline -f repaint'
bind --mode default gp 'git push; commandline -f repaint'
bind --mode insert \cg\cp 'git push; commandline -f repaint'

# git restore
bind --mode default \cg\cr 'git-restore-file; commandline -f repaint'
bind --mode default gr 'git-restore-file; commandline -f repaint'
bind --mode insert \cg\cr 'git-restore-file; commandline -f repaint'

# git status
bind --mode default \cg\cs 'git status; commandline -f repaint'
bind --mode default gs 'git status; commandline -f repaint'
bind --mode insert \cg\cs 'git status; commandline -f repaint'

#bind --mode insert \cg\cw\ca 'git worktree add'
bind --mode insert \cg\cw\cl 'git worktree list; commandline -f execute'
#bind --mode insert \cg\cw\cr 'git worktree remove'
