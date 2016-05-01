
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export EDITOR=vim

os=`uname`
if [[ "Darwin" == "${os}" ]]; then
    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced
elif [[ "Linux" == "${os}" ]]; then
    alias vi="vim"
    # to support vim 256 color schemes
    export TERM=xterm-256color
fi

export PATH=~/bin:${PATH}

export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# source git branch auto-complete
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

