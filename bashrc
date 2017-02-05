#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias tod="echo $(env TZ="America/New_York" date +'%r')"
PS1='[\u@\h \W]\$ '
export XDG_CONFIG_HOME=~/.config/
export ANDROID_HOME=/opt/android-sdk
export _JAVA_AWT_WM_NONREPARENTING=1
