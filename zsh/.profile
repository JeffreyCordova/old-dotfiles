#                       _____ __   
#     ____  _________  / __(_) /__ 
#    / __ \/ ___/ __ \/ /_/ / / _ \
#   / /_/ / /  / /_/ / __/ / /  __/
#  / .___/_/   \____/_/ /_/_/\___/ 
# /_/                              


#   -----
#---[env]-----------------------------------------------------------------------
#   -----

export EDITOR="nvim"
export PAGER="less"
export GREP_COLOR="0;34"

#   -----------
#---[ssh-agent]-----------------------------------------------------------------
#   -----------

#env=~/.ssh/agent.env

#agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

#agent_start () {
#	(umask 077; ssh-agent >| "$env")
#	. "$env" >| /dev/null ; }
 
#agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
#agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

#if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
#	agent_start
#	ssh-add
#elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
#	ssh-add
#fi

#unset env

#   -------------
#---[colored man]---------------------------------------------------------------
#   -------------

LESS_TERMCAP_mb=$(printf "\e[0;34m")    # start blink
LESS_TERMCAP_md=$(printf "\e[0;34m")    # start bold
LESS_TERMCAP_so=$(printf "\e[7;34m")    # start standout
LESS_TERMCAP_us=$(printf "\e[1;4;34m")  # start underline
LESS_TERMCAP_me=$(printf "\e[0m")       # stop blink, bold
LESS_TERMCAP_se=$(printf "\e[0m")       # stop standout
LESS_TERMCAP_ue=$(printf "\e[0m")       # stop underline

export LESS_TERMCAP_mb
export LESS_TERMCAP_md
export LESS_TERMCAP_so
export LESS_TERMCAP_us
export LESS_TERMCAP_me
export LESS_TERMCAP_se
export LESS_TERMCAP_ue

#   ------
#---[PATH]----------------------------------------------------------------------
#   ------

export PATH="${HOME}/.local/bin:${PATH}"
export MANPATH="${HOME}/.local/share/man:${MANPATH}"

export PATH="${HOME}/.node_modules/bin:${PATH}"
export npm_config_prefix=~/.node_modules

export PATH="${HOME}/.cargo/bin:${PATH}"

export PATH="${HOME}/julia/usr/bin:${PATH}"

export PATH="${HOME}/.poetry/bin:$PATH"

