#!/bin/bash
export BASH_PROFILE=$(readlink -f ${BASH_SOURCE[0]})
export MYSCRIPTS=$(dirname ${BASH_PROFILE})

source ${MYSCRIPTS}/aliases.sh
# Useful prompt
GIT_PROMPT=/etc/bash_completion.d/git-prompt
[ -f ${GIT_PROMPT} ] && source ${GIT_PROMPT} || echo no GIT_PROMPT file
PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]$(__git_ps1 | xargs)\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\$ '
