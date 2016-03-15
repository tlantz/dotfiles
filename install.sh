#!/bin/bash
# simple script to link home directory dot files to files in repo
thisdir=`dirname $0`
pushd ${thisdir} > /dev/null
thisdir=`pwd`
echo "Installing 3rd party helpers"
gitcompletion=~/.gitcompletion.bash
if [[ ! -f ${gitcompletion} ]]; then
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ${gitcompletion}
    chmod 754 ${gitcompletion}
fi

# if we're on OSX go build program for command line screen locking
if [[ "Darwin" -eq "`uname`" ]]; then
    pushd osx/gone
    make
    mkdir -p ../../stage/bin
    cp bin/gone ../../stage/bin
    popd
fi

# install all the stuff
stagedir=`pwd`/stage
for file in `ls -A ${stagedir} | grep '^\..*' | grep -v '^.git$'`; do
    destfile=~/${file}
    if [[ (-e ${destfile}) && (! -L ${destfile}) ]]; then
        echo "WARN: skipping ${file}, hard content exists"
    else
        if [[ -L ${destfile} ]]; then
            echo "WARN: removing existing symlink at ${destfile}"
            rm ${destfile}
        fi
        fullpath=${stagedir}/${file}
        echo "INFO: linking ${destfile} -> ${fullpath}"
        ln -s ${fullpath} ${destfile}
    fi
done
popd > /dev/null

