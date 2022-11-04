#              __             
#  ____  _____/ /_  __________
# /_  / / ___/ __ \/ ___/ ___/
#  / /_(__  ) / / / /  / /__  
# /___/____/_/ /_/_/   \___/  
#                             


#   ---------
#---[plugins]-------------------------------------------------------------------
#   ---------

source /usr/share/zsh/scripts/zplug/init.zsh

zplug "zdharma/fast-syntax-highlighting", defer:2

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

#   -----------------------
#---[no history duplicates]-----------------------------------------------------
#   -----------------------

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

#   -----------------------------
#---[case-insensitive completion]-----------------------------------------------
#   -----------------------------

zstyle ':completion:*' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

#   ---------
#---[hotkeys]-------------------------------------------------------------------
#   ---------

bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history

bindkey '^?' backward-delete-char

#bindkey '^r' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward
bindkey -M vicmd 'k' history-beginning-search-backward

bindkey -M vicmd 'K' run-help

export KEYTIMEOUT=1

#   ---------
#---[aliases]-------------------------------------------------------------------
#   ---------

alias ls="ls++"
alias l="ls -a"

alias grep="grep --color=auto"

alias path='printf "${PATH//:/\\n}\n"'

alias reflector="sudo reflector --verbose \
                                --protocol https \
                                --country 'United States' \
                                --latest 50 \
                                --fastest 10 \
                                --sort rate \
                                --save /etc/pacman.d/mirrorlist"

alias pacbrowse="pacman -Qq | \
                     fzf --preview 'pacman -Qil {}' \
                         --layout=reverse \
                         --bind 'enter:execute(pacman -Qil {} | less)'"

#   --------
#---[prompt]--------------------------------------------------------------------
#   --------

eval "$(starship init zsh)"

