# aws credentials env variables
source ${HOME}/.zshcustom/aws_creds.sh

# vi mode
bindkey -v

# set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# fzf git integration
source ${HOME}/.zshcustom/fzf-git.sh

# pure prompt
# https://github.com/sindresorhus/pure
fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
prompt pure

_miniconda_bin_conda="$HOME/miniconda3/bin/conda"
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$($_miniconda_bin_conda 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# node version manager (nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# zsh autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest

# homebrew paths
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# humdrum toolkit paths
export PATH="$HOME/humdrum-tools/humdrum/bin:$PATH"
export PATH="$HOME/humdrum-tools/humextra/bin:$PATH"

# aliases
alias v=nvim
alias cdc="cd $HOME/chrysalis"
alias pkm="cd $HOME/chrysalis/pkm"
alias dot="cd $HOME/chrysalis/sys/dotfiles"

# set working directory
cdc
