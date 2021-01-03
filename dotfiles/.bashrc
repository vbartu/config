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
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh --color=auto --group-directories-first'
alias la='ls -Alhv --color=auto --group-directories-first'
alias ..='cd ..'
alias cl='clear -x'
alias grep='grep --color=auto'
alias guide='cat ~/devel/config/docs/guide'
alias make='make -j'
alias rm="echo"

# Functions
rr() {
	if [ $# -ne 0 ]; then
		mv $* $HOME/.trash
	fi
}

# JLink alias
alias jl='JLinkExe -if SWD -speed 4000 -device NRF52840_XXAA -autoconnect 1'
alias jls='JLinkExe -if SWD -speed 4000 -device NRF52840_XXAA -autoconnect 1 -SelectEmuBySN'
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
export EDITOR=nvim

PS1="\033[36m[\033[1m\u\033[m\033[36m@\h \033[33m\W\033[36m]$ \033[m"
