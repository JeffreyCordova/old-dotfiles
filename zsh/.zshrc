#              __             
#  ____  _____/ /_  __________
# /_  / / ___/ __ \/ ___/ ___/
#  / /_(__  ) / / / /  / /__  
# /___/____/_/ /_/_/   \___/  
#                             

#export DISPLAY=:0

#---[load zplug]-------------------------------------------------------------
source /usr/share/zsh/scripts/zplug/init.zsh

#---[plugins]-------------------------------------------------------------------
zplug "denysdovhan/spaceship-zsh-theme", use:spaceship.zsh, from:github, as:theme
zplug "zdharma/fast-syntax-highlighting", defer:2

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

#---[no history duplicates]-----------------------------------------------------
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

#---[case-insensitive completion]-----------------------------------------------
zstyle ':completion:*' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

#---[vi mode]-------------------------------------------------------------------
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history

bindkey '^?' backward-delete-char

bindkey '^r' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward
bindkey -M vicmd 'k' history-beginning-search-backward

bindkey -M vicmd 'K' run-help

export KEYTIMEOUT=1

#---[aliases]-------------------------------------------------------------------
alias ls="ls_extended"
alias l="ls -alh"
alias grep="grep --color=auto"

#---[PATH]
alias path='printf "${PATH//:/\\n}\n"'

#---[update mirrors]
alias reflector="sudo reflector --verbose \
                                --protocol https \
                                --latest 200 \
                                --sort rate \
                                --save /etc/pacman.d/mirrorlist"

#---[spaceship theme settings]--------------------------------------------------
SPACESHIP_DIR_TRUNC=0
SPACESHIP_BATTERY_SHOW=false
spaceship_vi_mode_enable
