#              __             
#  ____  _____/ /_  __________
# /_  / / ___/ __ \/ ___/ ___/
#  / /_(__  ) / / / /  / /__  
# /___/____/_/ /_/_/   \___/  
#                             


#---[PATH]----------------------------------------------------------------------
export PATH="${HOME}/.local/bin:${PATH}"
export MANPATH="${HOME}/.local/share/man:$MANPATH"

#---[zplug loading]-------------------------------------------------------------
source /usr/share/zsh/scripts/zplug/init.zsh

#---[plugins]-------------------------------------------------------------------
MINIMAL_OK_COLOR=4

zplug "JeffreyCordova/minimal", use:minimal.zsh, from:github, as:theme
zplug "zsh-users/zsh-syntax-highlighting", defer:2

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

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
alias ls="ls --color=auto"
alias l="ls -lah"
alias grep="grep --color=auto"

alias reflector="sudo reflector --verbose \
                                --protocol https \
                                -l 200 \
                                --sort rate \
                                --save /etc/pacman.d/mirrorlist"

