#!/bin/bash
# make sure git is installed, otherwise you're sort of screwed
gitpath=`which git`
if [ -e "${gitpath}" ]; then
    echo "INFO: git found at [${gitpath}]"
else
    echo "ERROR: git not found, please install first!"
    exit 1
fi

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

# regardless of system, we try to link this at the end of the script even
# if it turns up being empty, so may as well just create it, doesn't hurt
stagedir="${thisdir}/stage"
stagebin="${stagedir}/bin"
echo "INFO: find or create [${stagebin}]"
mkdir -p ${stagebin}

# if we're on OSX go build program for command line screen locking
thisos=`uname`
if [[ "Darwin" == "${thisos}" ]]; then
    echo "INFO: building command line screen lock..."
    pushd osx/gone
    make
    cp bin/gone ${stagebin}
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
linkstuff "${stagedir}" ~
linkstuff "${stagebin}" ~/bin

popd > /dev/null

