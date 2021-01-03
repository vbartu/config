[1mdiff --git a/docs/arch-install b/docs/arch-install[m
[1mindex fa9eea2..e4d2083 100644[m
[1m--- a/docs/arch-install[m
[1m+++ b/docs/arch-install[m
[36m@@ -33,12 +33,13 @@[m [mConfigure system[m
 [m
 Boot[m
   pacman -S grub efibootmgr intel-ucode os-prober[m
[31m-  grub-install --target=x86_64-efi --efi-directory=esp --bootloader-id=GRUB[m
[32m+[m[32m  grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB[m
   grub-mkconfig -o /boot/grub/grub.cfg[m
   efibootmgr -v[m
 [m
 User[m
   useradd -m vicente (creates home folder)[m
[32m+[m[32m  passwd vicente[m
   pacman -S sudo[m
   sudo -lU vicente[m
   EDITOR=vim visudo (Uncomment wheel group)[m
[1mdiff --git a/dotfiles/.bashrc b/dotfiles/.bashrc[m
[1mindex f81ea13..4ec1fab 100644[m
[1m--- a/dotfiles/.bashrc[m
[1m+++ b/dotfiles/.bashrc[m
[36m@@ -13,18 +13,26 @@[m
 [[ -r /usr/share/fzf/completion.bash ]] && . /usr/share/fzf/completion.bash[m
 [m
 # Alias[m
[31m-alias ls='ls --color=auto'[m
[31m-alias ll='ls -lh --color=auto'[m
[31m-alias la='ls -alh --color=auto'[m
[32m+[m[32malias ls='ls --color=auto --group-directories-first'[m
[32m+[m[32malias ll='ls -lh --color=auto --group-directories-first'[m
[32m+[m[32malias la='ls -Alhv --color=auto --group-directories-first'[m
 alias ..='cd ..'[m
 alias cl='clear -x'[m
 alias grep='grep --color=auto'[m
 alias guide='cat ~/devel/config/docs/guide'[m
 alias make='make -j'[m
[32m+[m[32malias rm="echo"[m
[32m+[m
[32m+[m[32m# Functions[m
[32m+[m[32mrr() {[m
[32m+[m	[32mif [ $# -ne 0 ]; then[m
[32m+[m		[32mmv $* $HOME/.trash[m
[32m+[m	[32mfi[m
[32m+[m[32m}[m
 [m
 # JLink alias[m
[31m-alias jl='JLinkExe -if SWD -speed 4000 -device NRF52832_XXAA -autoconnect 1'[m
[31m-alias jls='JLinkExe -if SWD -speed 4000 -device NRF52832_XXAA -autoconnect 1 -SelectEmuBySN'[m
[32m+[m[32malias jl='JLinkExe -if SWD -speed 4000 -device NRF52840_XXAA -autoconnect 1'[m
[32m+[m[32malias jls='JLinkExe -if SWD -speed 4000 -device NRF52840_XXAA -autoconnect 1 -SelectEmuBySN'[m
 alias jlc='JLinkRTTClient'[m
 [m
 # PATH[m
[36m@@ -41,7 +49,6 @@[m [mexport PROMPT_COMMAND='history -a'[m
 [m
 # Some config[m
 export LESSHISTFILE=-[m
[31m-export EDITOR=vim[m
[32m+[m[32mexport EDITOR=nvim[m
 [m
[31m-# Prompt[m
[31m-PS1="\[\e[32m\][\[\e[m\]\[\e[1;32m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]\[\e[32m\] \[\e[m\]\[\e[33m\]\W\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32m\]\\$\[\e[m\]\[\e[32m\] \[\e[m\]"[m
[32m+[m[32mPS1="\033[36m[\033[1m\u\033[m\033[36m@\h \033[33m\W\033[36m]$ \033[m"[m
