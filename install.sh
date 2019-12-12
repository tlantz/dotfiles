#!/bin/bash
# we actually need a bunch of stuff installed via sudo before we start
# so this is a kill and tell you to do something loop until you meet
# all the prereqs, makes it obvious what's failing on a new install
# before half assing the setup without some requirements, silent
# failures, etc
function checkapp {
    app=${1}
    apppath=`which ${app}`
    if [ -e "${apppath}" ]; then
        echo "INFO: [${app}] found at [${apppath}]"
        if [ ! -x "${apppath}" ]; then
            echo "ERROR: [${apppath}] must be executable, please fix first!"
            exit 1
        fi
    else
        echo "ERROR: required app [${app}] not found, please install first!"
        exit 1
    fi
}

function setup_osx_terminal {
    terminal_plist="~/Library/Preferences/com.apple.Terminal.plist"
    defaults write "${terminal_plist}" "Default Window Settings" -string "Pro"
    defaults write "${terminal_plist}" "Startup Window Settings" -string "Pro"
}

checkapp git
checkapp curl
checkapp nvim
checkapp shellcheck
if [[ "Darwin" == `uname` ]]; then
    checkapp clang
    setup_osx_terminal
fi

# simple script to link home directory dot files to files in repo
thisdir=`dirname $0`
pushd ${thisdir} > /dev/null
thisdir=`pwd`
echo "INFO: installing 3rd party helpers"
echo "INFO: installing git completion"
gitcompletion=~/.gitcompletion.bash
if [[ ! -f ${gitcompletion} ]]; then
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ${gitcompletion}
    chmod 754 ${gitcompletion}
fi
vundleroot=~/.vim/bundle/Vundle.vim
if [[ ! -d "${vundleroot}" ]]; then
    echo "INFO: installing vundle"
    git clone https://github.com/VundleVim/Vundle.vim.git ${vundleroot}
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

# we stage a bunch of runnable scripts in stage/scripts
echo "INFO: copying scripts to bin..."
for f in `ls scripts/`; do
    oldpath="scripts/${f}"
    newpath="${stagebin}/${f}"
    echo "INFO: copying [${oldpath}] => [${newpath}]"
    cp ${oldpath} ${newpath}
done
chmod -R 754 "${stagebin}"

# install all the stuff
function linkstuff {
    from=${1}
    to=${2}
    if [[ ! -d ${to} ]]; then
        echo "Creating directory [${to}]..."
        mkdir -p ${to}
    fi
    for file in `find ${from}`; do
        # Get just the name for path manipulation.
        exp="s^${from}/^^g"
        relfile=`echo ${file} | sed "${exp}"`
        srcfile="${file}"
        destfile="${to}/${relfile}"
        # Un-comment these two lines and inspect before you blow away your day. *_*
        # echo "INFO: file=${file}, srcfile=${srcfile}, destfile=${destfile}"
        # continue
        if [[ -d ${srcfile} ]]; then
            echo "INFO: directory encountered at [${srcfile}]"
            if [[ ! -d "${destfile}" ]]; then
                echo "INFO: creating directory [${desfile}]"
                mkdir -p ${destfile}
            fi
        elif [[ (-e ${destfile}) && (! -L ${destfile}) ]]; then
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

# Hook into .bash_profile cleanly.
bash_profile_hook_line="[[ -s ~/.bash_tlantz ]] && source ~/.bash_tlantz"
fgrep "${bash_profile_hook_line}" ~/.bash_profile >> /dev/null
grep_retval="${?}"
if [[ "0" != "${grep_retval}" ]]; then
    echo "INFO: appending hook into bash profile adds to .bash_profile"
    echo "" >> ~/.bash_profile
    echo "# Added by tlantz/dotfiles/install.sh" >> ~/.bash_profile
    echo "${bash_profile_hook_line}" >> ~/.bash_profile
    echo "" >> ~/.bash_profile
fi

popd > /dev/null
