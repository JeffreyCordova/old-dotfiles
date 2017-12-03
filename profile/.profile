#                       _____ __   
#     ____  _________  / __(_) /__ 
#    / __ \/ ___/ __ \/ /_/ / / _ \
#   / /_/ / /  / /_/ / __/ / /  __/
#  / .___/_/   \____/_/ /_/_/\___/ 
# /_/                              

#---[env]-----------------------------------------------------------------------
export EDITOR="nvim"
export PAGER="less"
export GREP_COLOR="0;34"

#---[colored man]---------------------------------------------------------------
export LESS_TERMCAP_mb=$(printf "\e[0;34m")	# start blink
export LESS_TERMCAP_md=$(printf "\e[0;34m")	# start bold
export LESS_TERMCAP_so=$(printf "\e[7;34m")	# start standout
export LESS_TERMCAP_us=$(printf "\e[1;4;34m")	# start underline
export LESS_TERMCAP_me=$(printf "\e[0m")	# stop blink, bold
export LESS_TERMCAP_se=$(printf "\e[0m")	# stop standout
export LESS_TERMCAP_ue=$(printf "\e[0m")	# stop underline

#---[PATH]----------------------------------------------------------------------
export PATH="${HOME}/.local/bin:${PATH}"
export MANPATH="${HOME}/.local/share/man:$MANPATH"

