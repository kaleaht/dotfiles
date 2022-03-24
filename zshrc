DIR=${0:a:h}

source $DIR/antigen.zsh
antigen bundle jeffreytse/zsh-vi-mode
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme denysdovhan/spaceship-prompt
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$key[Up]" up-line-or-beginning-search
bindkey "$key[Down]" down-line-or-beginning-search
bindkey -M vicmd k up-line-or-beginning-search
bindkey -M vicmd j down-line-or-beginning-search

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
export HISTFILE=~/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Use neovim if it is available
if type nvim > /dev/null; then
  export EDITOR="nvim"
  alias vim=nvim
  alias vi=nvim
fi
alias ls="ls --color=auto"
alias ll="ls -lh --color=auto"
alias la="ls -a --color=auto"
alias lla="ls -lha --color=auto"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# ls with premission code
ls_premission_code() {
  ls -l | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf("%0o ",k);print}'
}
alias lsn=ls_premission_code


alias open="xdg-open"
