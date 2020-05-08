#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# set vi mode
set -o vi

# set terminal title to working directory
PROMPT_COMMAND='echo -ne "\033]0;${PWD/$HOME/"~"}\007"'
