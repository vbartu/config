# Resize correctly
shopt -s checkwinsize

# Colors are compeltely messed up due to windows permissions
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Not really sure, probably better not to touch it
. /etc/profile.d/fw_devel.sh
set_toolchain arm-compiler-6.13

# Alias
alias cd2='cd /mnt/c/w'
alias cd3='cd /mnt/c/Users/VicenteBartual/OneDrive\ -\ Kigen/Desktop'
alias clip="clip.exe"
alias exp='explorer.exe .'
alias firefox="firefox_launcher.py"

# Enable graphics apps in WSL
[[ -z "$DISPLAY" ]] && export DISPLAY=:0

export PS1="\[\e[36m\][\u@\e[32m\h \[\e[33m\]\W\[\e[36m\]]\\$\[\e[m\] "
