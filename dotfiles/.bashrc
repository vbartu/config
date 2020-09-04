#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Autocomplete
[[ -r /usr/share/bash-completion/completions/systemctl ]] && . /usr/share/bash-completion/completions/systemctl
[[ -r /usr/share/bash-completion/completions/git ]] && . /usr/share/bash-completion/completions/git
[[ -r /usr/share/fzf/key-bindings.bash ]] && . /usr/share/fzf/key-bindings.bash
[[ -r /usr/share/fzf/completion.bash ]] && . /usr/share/fzf/completion.bash

# Alias
alias ls='ls --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -alh --color=auto'
alias ..='cd ..'
alias grep='grep --color=auto'
alias guide='cat ~/devel/config/docs/guide'
alias make='make -j'

# JLink alias
alias jl='JLinkExe -if SWD -speed 4000 -device NRF52832_XXAA -autoconnect 1'
alias jls='JLinkExe -if SWD -speed 4000 -device NRF52832_XXAA -autoconnect 1 -SelectEmuBySN'
alias jlc='JLinkRTTClient'

# PATH
export PATH=~/.local/bin:~/devel/config/scripts:$PATH

# History tweaks
shopt -s histappend
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=erasedups
export HISTCONTROL='erasedups:ignoreboth'
export HISTIGNORE=?:??
export PROMPT_COMMAND='history -a'

# Some config
export LESSHISTFILE=-
export EDITOR=vim

# Prompt
PS1="\[\e[32m\][\[\e[m\]\[\e[1;32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]\[\e[32m\] \[\e[m\]\[\e[33m\]\W\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32m\]\\$\[\e[m\]\[\e[32m\] \[\e[m\]"
