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
function linkstuff {
    from=${1}
    to=${2}
    if [[ ! -d ${to} ]]; then
        echo "Creating directory [${to}]..."
        mkdir -p ${to}
    fi
    for file in `ls -A ${from}`; do
        srcfile="${from}/${file}"
        destfile="${to}/${file}"
        if [[ -d ${srcfile} ]]; then
            continue
        fi
        if [[ (-e ${destfile}) && (! -L ${destfile}) ]]; then
            echo "WARN: skipping ${file}, hard content exists"
        else
            if [[ -L ${destfile} ]]; then
                echo "WARN: removing existing symlink at ${destfile}"
                rm ${destfile}
            fi
            echo "INFO: linking ${destfile} -> ${srcfile}"
            ln -s ${srcfile} ${destfile}
        fi
    done
}
linkstuff "${thisdir}/stage" ~
linkstuff "${thisdir}/stage/bin" ~/bin

popd > /dev/null

