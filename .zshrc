
autoload -U promptinit; promptinit

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

HISTSIZE=9000
SAVEHIST=9000
HISTFILE=~/.zsh_history


source ~/.zplug/init.zsh

# Make sure to use double quotes
zplug "zsh-users/zsh-history-substring-search"

# Use the package as a command
# And accept glob patterns (e.g., brace, wildcard, ...)
zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"

# Supports oh-my-zsh plugins and the like
zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/yarn",   from:oh-my-zsh

# Also prezto
zplug "modules/prompt", from:prezto

# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# pure prompt
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme


# fuzzy filtering
zplug "junegunn/fzf", as:command, hook-build:"./install --all --no-bash --no-fish", use:"bin/{fzf-tmux,fzf}"

# Can manage local plugins
zplug "~/.zsh/plugins", from:local

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [Y/n]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH




[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

zplug load

prompt pure

# Need source last to overwrite other aliases
source $HOME/.fzf.settings
source $HOME/.aliases
source $HOME/functions.sh
source $HOME/.bindkeys

