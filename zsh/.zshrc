#### VI MODE ####
bindkey -v

#### PATHS ####
arch=$(uname -m)
if [[ "$OSTYPE" == darwin* ]]; then
    if [[ "$arch" == "arm64" ]]; then
        export PATH="/opt/homebrew/bin:$PATH"
        export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
    fi
fi
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME/humdrum-tools/humdrum/bin:$PATH"
export PATH="$HOME/humdrum-tools/humextra/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"

#### COMMAND LINE ####
# pure prompt
# https://github.com/sindresorhus/pure
fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
prompt pure
# zsh autosuggestions
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest

#### PROGRAM-SPECIFIC REQUIREMENTS ####
# fzf: setup key bindings, fuzzy completion, git integration
source <(fzf --zsh)
source ${HOME}/.zshcustom/fzf-git.sh
# node version manager (nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#### ENVIRONMENT VARIABLES ####
# default editor
export EDITOR=nvim
# aws credentials env variables
source ${HOME}/.zshcustom/aws_creds.sh
# other env variables
source ${HOME}/.zshcustom/env_vars.sh

#### ALIASES ####
alias v=nvim
alias cdc="cd $HOME/chrysalis"
alias pkm="cd $HOME/chrysalis/pkm"
alias dot="cd $HOME/chrysalis/sys/dotfiles"
alias gw="git worktree"
alias j="jira issue list -a$(jira me) --order-by status --reverse"
if [[ "$OSTYPE" == darwin* ]]; then
    alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fi

#### SET WORKING DIRECTORY ####
cdc
