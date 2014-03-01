#!/bin/bash
# simple script to link home directory dot files to files in repo
thisdir=`dirname $0`
pushd ${thisdir} > /dev/null
thisdir=`pwd`
for file in `ls -A | grep '^\..*' | grep -v '^.git$'`; do
    destfile=~/${file}
    if [[ (-e ${destfile}) && (! -L ${destfile}) ]]; then
        echo "WARN: skipping ${file}, hard content exists"
    else
        if [[ -L ${destfile} ]]; then
            echo "WARN: removing existing symlink at ${destfile}"
            rm ${destfile}
        fi
        fullpath=`pwd`/${file}
        echo "INFO: linking ${destfile} -> ${fullpath}"
        ln -s ${fullpath} ${destfile}
    fi
done
popd > /dev/null

