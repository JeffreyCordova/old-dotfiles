#          ___                     
#   ____ _/ (_)___ _________  _____
#  / __ `/ / / __ `/ ___/ _ \/ ___/
# / /_/ / / / /_/ (__  )  __(__  ) 
# \__,_/_/_/\__,_/____/\___/____/  
#                                  

#---[colors]--------------------------------------------------------------------
alias ls="ls_extended"
alias l="ls -alh"
alias grep="grep --color=auto"

#---[print PATH]----------------------------------------------------------------
alias path='printf "${PATH//:/\\n}\n"'

#---[update mirrors]------------------------------------------------------------
alias reflector="sudo reflector --verbose \
                                --latest 200 \
                                --sort rate \
                                --save /etc/pacman.d/mirrorlist"

#---[browse installed packages]-------------------------------------------------
alias pacbrowse="pacman -Qq | fzf --preview 'pacman -Qil {}' \
                                  --layout=reverse \
                                  --bind 'enter:execute(pacman -Qil {} | less)'"
