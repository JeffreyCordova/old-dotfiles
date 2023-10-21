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
export GREP_COLORS="mt=0;34"

#   -------------------
#---[colored man pages]---------------------------------------------------------
#   -------------------

export LESS_TERMCAP_mb=$(printf "\e[01;32m")     # start blink
export LESS_TERMCAP_md=$(printf "\e[01;32m")     # start bold
export LESS_TERMCAP_me=$(printf "\e[0m")         # stop blink, bold
export LESS_TERMCAP_se=$(printf "\e[0m")         # stop standout
export LESS_TERMCAP_so=$(printf "\e[01;47;34m")  # start standout
export LESS_TERMCAP_ue=$(printf "\e[0m")         # stop underline
export LESS_TERMCAP_us=$(printf "\e[01;36m")     # start underline

#   ------
#---[PATH]----------------------------------------------------------------------
#   ------

export PATH="${HOME}/.local/bin:${PATH}"
export MANPATH="${HOME}/.local/share/man:${MANPATH}"

export PATH="${HOME}/.node_modules/bin:${PATH}"
export npm_config_prefix=~/.node_modules

export PATH="${HOME}/.cargo/bin:${PATH}"

export PATH="${HOME}/julia/usr/bin:${PATH}"

export PATH="${HOME}/.poetry/bin:${PATH}"


# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/jeff/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/jeff/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<
