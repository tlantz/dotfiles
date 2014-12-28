
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

os=`uname`
if [[ "Darwin" == "${os}" ]]; then
    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced
elif [[ "Linux" == "${os}" ]]; then
    alias vi="vim"
fi

export PATH=~/bin:${PATH}

