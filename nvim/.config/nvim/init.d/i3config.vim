aug i3config_ft_detection
    au!
    au BufNewFile,BufRead $HOME/.config/i3/config set filetype=i3config
    au BufNewFile,BufRead $HOME/dotfiles/i3/.config/i3/config set filetype=i3config
aug end
