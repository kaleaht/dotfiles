DIR=${0:a:h}

source $DIR/antigen.zsh

antigen bundle jeffreytse/zsh-vi-mode
# Tell Antigen that you're done.
antigen apply
