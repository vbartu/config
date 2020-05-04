#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Alias
alias ls='ls --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -alh --color=auto'
alias ..='cd ..'
alias grep='grep --color=auto'
alias guide='cat ~/devel/docs/arch-guide'
alias gitlog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

# JLink alias
alias jl='JLinkExe -if SWD -speed 4000 -device NRF52832_XXAA -autoconnect 1'
alias jls='JLinkExe -if SWD -speed 4000 -device NRF52832_XXAA -autoconnect 1 -SelectEmuBySN'
alias jlc='JLinkRTTClient'

# PATH
export PATH=~/.local/bin:$PATH

# History tweaks
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=erasedups
export PROMPT_COMMAND='history -a'

# Git editor
export EDITOR=vim

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# Prompt
PS1="\[\e[32m\][\[\e[m\]\[\e[1;32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]\[\e[32m\] \[\e[m\]\[\e[33m\]\W\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32m\]\\$\[\e[m\]\[\e[32m\] \[\e[m\]"
