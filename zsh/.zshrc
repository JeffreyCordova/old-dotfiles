#              __             
#  ____  _____/ /_  __________
# /_  / / ___/ __ \/ ___/ ___/
#  / /_(__  ) / / / /  / /__  
# /___/____/_/ /_/_/   \___/  
#                             

#---[Windows X-server config]---------------------------------------------------
export $(dbus-launch)
export LIBGL_ALWAYS_INDIRECT=1

export WSL_VERSION=$(wsl.exe -l -v | grep -a '[*]' | sed 's/[^0-9]*//g')
export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
export DISPLAY=$WSL_HOST:0

#---[plugins]----------------------------------------------------------------
source ~/dotfiles/zsh/.zsh/plugins.zsh

#---[no history duplicates]-----------------------------------------------------
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

#---[case-insensitive completion]-----------------------------------------------
zstyle ':completion:*' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

#---[hotkeys]-------------------------------------------------------------------
source ~/dotfiles/zsh/.zsh/hotkeys.zsh

#---[aliases]-------------------------------------------------------------------
source ~/dotfiles/zsh/.zsh/aliases.zsh
