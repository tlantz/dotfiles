
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
if [[ -d ${HOME}/bin ]]; then
    PATH=${HOME}/bin:${PATH}
fi
export PATH
export EDITOR=nvim
export NVM_DIR="/Users/tlantz/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias vi=nvim
alias vim=nvim
