#### VI MODE ####
bindkey -v

#### CUSTOM SCRIPTS ####
# aws credentials env variables
source ${HOME}/.zshcustom/aws_creds.sh
# fzf: setup key bindings, fuzzy completion, git integration
source <(fzf --zsh)
source ${HOME}/.zshcustom/fzf-git.sh

#### COMMAND LINE ####
# pure prompt
# https://github.com/sindresorhus/pure
fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
prompt pure
# zsh autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest

#### PROGRAM-SPECIFIC REQUIREMENTS ####
### node version manager (nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#### PATHS ####
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/humdrum-tools/humdrum/bin:$PATH"
export PATH="$HOME/humdrum-tools/humextra/bin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"

#### ALIASES ####
alias v=nvim
alias cdc="cd $HOME/chrysalis"
alias pkm="cd $HOME/chrysalis/pkm"
alias dot="cd $HOME/chrysalis/sys/dotfiles"
if [[ "$OSTYPE" == darwin* ]]; then
    alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fi

#### SET WORKING DIRECTORY ####
cdc
