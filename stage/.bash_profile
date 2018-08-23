
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export EDITOR=vim

os=`uname`
if [[ "Darwin" == "${os}" ]]; then
    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced
    alias saver="/System/Library/Frameworks/ScreenSaver.framework/Versions/Current/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine"
elif [[ "Linux" == "${os}" ]]; then
    alias vi="vim"
fi

export PATH=~/bin:${PATH}

export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# source git branch auto-complete
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

