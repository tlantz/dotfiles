
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
os=`uname`
if [[ "Darwin" == "${os}" ]]; then 
    export CLICOLOR=1
fi
