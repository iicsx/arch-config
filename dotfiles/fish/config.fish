function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

function mkcd
    mkdir -p $argv[1]
    cd $argv[1]
end

function fish_greeting
    echo -ne '\x1b[38;5;16m'  # Set colour to primary
    echo "   __     __     ______     ______     __  __    "
    echo "  /\ \   /\ \   /\  ___\   /\  ___\   /\_\_\_\   "
    echo "  \ \ \  \ \ \  \ \ \____  \ \___  \  \/_/\_\/_  "
    echo "   \ \_\  \ \_\  \ \_____\  \/\_____\   /\_\/\_\ "
    echo "    \/_/   \/_/   \/_____/   \/_____/   \/_/\/_/ "
    set_color normal
    fastfetch --key-padding-left 5
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

    starship init fish | source

    cat ~/.local/state/caelestia/sequences.txt 2> /dev/null
end

export EDITOR=nvim
export PATH="/home/nex/.ghcup/bin:$PATH"

alias v='$EDITOR'
alias vh='$EDITOR .'

alias la='ls -la'
alias ..='cd ..'
alias ...='cd ...'

alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gr='git restore'
alias grs='git restore --staged'
alias gb='git branch'
alias gc='git commit'
alias ga='git add'
alias glo='git log --oneline'

alias qo='qutebrowser -- :open'

alias sudoe='sudo -E -s'
alias nm='TERM=screen-256color neomutt'

zoxide init --cmd cd fish | source

# function fish_prompt
#   set_color cyan; echo (pwd)
#   set_color green; echo '> '
# end
