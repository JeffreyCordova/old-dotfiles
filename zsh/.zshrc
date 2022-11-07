#              __             
#  ____  _____/ /_  __________
# /_  / / ___/ __ \/ ___/ ___/
#  / /_(__  ) / / / /  / /__  
# /___/____/_/ /_/_/   \___/  
#                             


#   ---------
#---[plugins]-------------------------------------------------------------------
#   ---------

eval "$(sheldon source)"

#   -----------------
#---[general options]-----------------------------------------------------------
#   -----------------

setopt correct
setopt extendedglob
setopt nocaseglob
setopt rcexpandparam
setopt nocheckjobs
setopt numericglobsort
setopt longlistjobs
setopt nonomatch
setopt notify

export EDITOR=nvim

#   ---------
#---[history]-------------------------------------------------------------------
#   ---------

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=1000000000

setopt incappendhistory
setopt share_history
setopt extended_history
setopt histignorealldups
setopt histignorespace

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#   ------------
#---[completion]----------------------------------------------------------------
#   ------------

zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' rehash true
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

WORDCHARS=${WORDCHARS//\/[&.;]}
fpath=(~/.zfunc ~/.zsh/completions $fpath)

autoload -Uz compinit
for dump in ~/.zcompdump(#qN.mh+24); do
    compinit
done

compinit -C

#   ---------
#---[vi mode]-------------------------------------------------------------------
#   ---------

bindkey -v

export KEYTIMEOUT=1

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

#   -----
#---[fzf]-----------------------------------------------------------------------
#   -----

export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!.git/*"'

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

#   ---------
#---[aliases]-------------------------------------------------------------------
#   ---------

alias ls="ls++"
alias l="ls -a"

alias grep="grep --color=auto"

alias path='printf "${PATH//:/\\n}\n"'

alias reflector="sudo reflector --verbose \
                                --protocol https \
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

