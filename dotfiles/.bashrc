#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Autocomplete
[[ -r /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion
[[ -r /usr/share/fzf/key-bindings.bash ]] && . /usr/share/fzf/key-bindings.bash
[[ -r /usr/share/fzf/completion.bash ]] && . /usr/share/fzf/completion.bash

# Alias
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh --color=auto --group-directories-first'
alias la='ls -Alhv --color=auto --group-directories-first'
alias ..='cd ..'
alias cl='clear -x'
alias grep='grep --color=auto'
alias guide='cat ~/devel/config/docs/guide | less'
alias makej='make -j8'
alias duu='du -hd1 2>/dev/null | sort -hr'

# Keybinds
stty stop '' # Free ^S
bind '"\023":"\022"' # Bind to ^R
stty start '' # Free ^Q
bind '"\021":"\ec"' # Bind to Alt+C

# JLink
alias jl='JLinkExe -if SWD -speed 4000 -device NRF52840_XXAA -autoconnect 1'
alias jls='JLinkExe -if SWD -speed 4000 -device NRF52840_XXAA -autoconnect 1 -SelectEmuBySN'
alias jlc='JLinkRTTClient'
alias jl91='JLinkExe -if SWD -speed 4000 -device NRF9160_XXAA -autoconnect 1'
export JLINK_TARGET=682486629

# NRF Connect SDK
export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
export GNUARMEMB_TOOLCHAIN_PATH="/opt/gcc-arm-none-eabi-9-2019-q4-major"

# Flutter
export PATH=~/work/android/flutter/bin:$PATH
export PATH=~/work/android/cmdline-tools/latest/bin:$PATH
export ANDROID_SDK_ROOT=~/work/android
export CHROME_EXECUTABLE=/opt/google/chrome/chrome

# PATH
export PATH=~/.local/bin:$PATH
export PATH=~/devel/config/scripts:$PATH
export PATH=~/.cargo/bin:$PATH

# History tweaks
shopt -s histappend
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=erasedups
export HISTCONTROL='erasedups:ignoreboth'
export HISTIGNORE=?
export PROMPT_COMMAND='history -a'

# Misc
export LESSHISTFILE=-
export EDITOR=nvim
export FZF_DEFAULT_COMMAND='rg --files'

# Git agent
eval `ssh-agent` &> /dev/null
ssh-add ~/.ssh/id_ed25519 &> /dev/null

export PS1="\[\e[36m\][\[\e[m\]\[\e[36m\]\u\[\e[m\]\[\e[36m\]@\[\e[m\]\[\e[36m\]\h\[\e[m\] \[\e[33m\]\W\[\e[m\]\[\e[36m\]]\[\e[m\]\[\e[36m\]\\$\[\e[m\] "
