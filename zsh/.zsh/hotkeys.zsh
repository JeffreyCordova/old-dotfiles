#     __          __  __                  
#    / /_  ____  / /_/ /_____  __  _______
#   / __ \/ __ \/ __/ //_/ _ \/ / / / ___/
#  / / / / /_/ / /_/ ,< /  __/ /_/ (__  ) 
# /_/ /_/\____/\__/_/|_|\___/\__, /____/  
#                           /____/        

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