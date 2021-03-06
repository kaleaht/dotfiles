DIR=${0:a:h}

source $DIR/antigen.zsh
antigen bundle jeffreytse/zsh-vi-mode
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme denysdovhan/spaceship-prompt
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

# zsh-vi-mode fixes #
# fzf bindings
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
# autosuggest accept Ctrl + space
zvm_after_init_commands+=("bindkey '^ ' autosuggest-accept")

# use the vi navigation keys in menu completion
zstyle ':completion:*' menu select
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

export EDITOR="vim"
export SAVEHIST=1000
export HISTFILE=~/.zsh_history

# Use neovim if it is available
if type nvim > /dev/null; then
  export EDITOR="nvim"
  alias vim=nvim
  alias vi=nvim
fi
alias ll="ls -lh"
alias la="ls -a"
alias lla="ls -lha"
