#
# ~/.bash_profile
#
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec startx
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc

export QSYS_ROOTDIR="/home/vicente/uni/drone_project/quartus/quartus_19.1.0/installation/quartus/sopc_builder/bin"
