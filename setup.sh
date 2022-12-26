#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

create_file_if_not_exit () {
  if [ ! -f "$1" ]; then
    echo "$1 does not exist. We will create it."
    touch $1
  fi
}

append_if_not_exit () {
  if ! grep -q "$2" $1; then
    echo "Adding source file to $1"
    echo $2 >> $1
  fi
}

echo "Setting up tmux..."
TMUX_FILE=$HOME/.tmux.conf
create_file_if_not_exit $TMUX_FILE
TMUX_IMPORT="source-file $DIR/tmux.conf"
append_if_not_exit "$TMUX_FILE" "$TMUX_IMPORT"
echo "tmux done!"

echo "Setting up zsh..."
echo "Downloading antigen..."
curl -L git.io/antigen > $DIR/antigen.zsh
ZSH_FILE=$HOME/.zshrc
create_file_if_not_exit $ZSH_FILE
ZSH_IMPORT="source $DIR/zshrc"
append_if_not_exit "$ZSH_FILE" "$ZSH_IMPORT"
echo "zsh done!"

# Ask user to select from list of options
# Define the list of options
options=("Vimscript" "Lua" "Quit")

# Print the options
echo "Please select an option for neovim config:"
for i in "${!options[@]}"; do
    printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${options[i]}"
done

# Prompt the user to select an option
read -p "Enter your selection [1-${#options[@]}] " selection

# Check the selection and take the appropriate action
case $selection in
    1)
        # Action for Vimscript
        echo "You selected option Vimscript"
        echo "Setting up neovim using vimscript..."
        mkdir -p $HOME/.config/nvim
        NVIM_LINK=$HOME/.config/nvim/init.vim
        [ -L $NVIM_LINK ] || ln -s $DIR/vimrc $NVIM_LINK
        echo "Installing vim plug..."
        sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
               https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        echo "vim done!"
        ;;
    2)
        # Action for Lua
        echo "You selected option Lua."
        NVIM_LINK=$HOME/.config/nvim/init.lua
        if [ -L $NVIM_LINK ]; then
            echo "$NVIM_LINK already exist."
        else
            ln -s $DIR/init.lua $NVIM_LINK
            echo "$NVIM_LINK link created."
        fi
        ;;
    3)
        # Action for quit
        echo "Quitting."
        exit
        ;;
    *)
        # Invalid selection
        echo "Invalid selection. Please try again."
        ;;
esac

echo "Setting up alacritty..."
ALACRITTY_DIR=$HOME/.config/alacritty
mkdir -p $ALACRITTY_DIR
ALACRITTY_LINK=$ALACRITTY_DIR/alacritty.yml
[ -e $ALACRITTY_LINK ] && rm -i $ALACRITTY_LINK
[ -L $ALACRITTY_LINK ] || ln -s $DIR/alacritty.yml $ALACRITTY_LINK
echo "alacritty done!"
