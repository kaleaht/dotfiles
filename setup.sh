#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Making links

# filetype plugin for filetype specific vimrc
LINK=~/.vim/ftplugin 
if [ -d $LINK ]
then
	echo "ftplugin folder exists. No link crated."
else
	ln -s -T ${DIR}/ftplugin ${LINK}
	echo "ftplugin link crated ${LINK}"
fi

