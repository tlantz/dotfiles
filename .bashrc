
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
if [[ -d ${HOME}/bin ]]; then
    PATH=${HOME}/bin:${PATH}
fi
export PATH


export NVM_DIR="/Users/tlantz/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
