#              __                   
#  ____  _____/ /_  ___  ____ _   __
# /_  / / ___/ __ \/ _ \/ __ \ | / /
#  / /_(__  ) / / /  __/ / / / |/ / 
# /___/____/_/ /_/\___/_/ /_/|___/  
#                                   

#---[colors]--------------------------------------------------------------------
mainc="4"
sidec="$((mainc + 8))"

#---[history file]--------------------------------------------------------------
export HISTSIZE=1000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=1000

#---[syntax highlighting]-------------------------------------------------------
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=red"
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=$mainc"
ZSH_HIGHLIGHT_STYLES[alias]="fg=$mainc"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=$mainc"
ZSH_HIGHLIGHT_STYLES[function]="fg=$mainc"
ZSH_HIGHLIGHT_STYLES[command]="fg=$mainc"
ZSH_HIGHLIGHT_STYLES[precommand]="underline,fg=$mainc"
ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=blue"
ZSH_HIGHLIGHT_STYLES[hashed-command]="fg=$mainc"
ZSH_HIGHLIGHT_STYLES[globbing]="fg=yellow"
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]="fg=$sidec"
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]="fg=$sidec"
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=yellow"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=yellow"
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=blue"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=$sidec"
ZSH_HIGHLIGHT_STYLES[arg0]="fg=$mainc"

export ZSH_HIGHLIGHT_STYLES
export ZSH_HIGHLIGHT_HIGHLIGHTERS

