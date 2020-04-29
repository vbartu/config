#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Shell options
set autocd

# Alias
alias ls='ls --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -alh --color=auto'
alias ..='cd ..'
alias grep='grep --colour=auto'
alias cp="cp -i"                          # confirm before overwriting something
alias guide='cat ~/devel/docs/arch-guide'
alias gitlog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

# JLink alias
alias jl='JLinkExe -if SWD -speed 4000 -device NRF52832_XXAA -autoconnect 1'
alias jls='JLinkExe -if SWD -speed 4000 -device NRF52832_XXAA -autoconnect 1 -SelectEmuBySN'
alias jlc='JLinkRTTClient'

# History tweaks
shopt -s histappend
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL='erasedups:ignoreboth'
export HISTIGNORE=?:??
export PROMPT_COMMAND='history -a'

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Git editor
export EDITOR=vim

# Prompt
PS1="\[\e[32m\][\[\e[m\]\[\e[1;32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]\[\e[32m\] \[\e[m\]\[\e[33m\]\W\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32m\]\\$\[\e[m\]\[\e[32m\] \[\e[m\]"
