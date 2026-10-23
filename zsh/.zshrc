#### ENVIRONMENT ####
typeset -U path # drop duplicate PATH entries
path=(
  /Library/TeX/texbin
  ${GOPATH:-$HOME/go}/bin
  ~/humdrum-tools/{humextra,humdrum}/bin
  ~/.config/emacs/bin
  ~/.cargo/bin
  ~/.local/bin
  ${HOMEBREW_PREFIX:+$HOMEBREW_PREFIX/opt/postgresql@15/bin}
  $path
)
export EDITOR=nvim
source ~/.zshcustom/aws_creds.sh
source ~/.zshcustom/env_vars.sh

#### PLUGINS & TOOLS ####
# autosuggestions
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^[[Z' autosuggest-accept # shift+tab
# fzf
source <(fzf --zsh)
source ~/.zshcustom/fzf-git.sh
# nvm
export NVM_DIR="$HOME/.nvm"
[[ -s $NVM_DIR/nvm.sh ]] && source $NVM_DIR/nvm.sh
[[ -s $NVM_DIR/bash_completion ]] && source $NVM_DIR/bash_completion

#### ALIASES ####
alias v=nvim
alias gw='git worktree'
alias cdc='cd ~/chrysalis'
alias pkm='cd ~/chrysalis/pkm'
alias dot='cd ~/chrysalis/sys/dotfiles'
alias j='jira issue list -a"$(jira me)" --order-by status --reverse'
[[ $OSTYPE == darwin* ]] && alias tailscale=/Applications/Tailscale.app/Contents/MacOS/Tailscale

#### PROMPT ####
autoload -Uz vcs_info add-zsh-hook add-zle-hook-widget
zmodload zsh/datetime
setopt PROMPT_SUBST

# vi mode: > insert, < normal
bindkey -v; KEYTIMEOUT=1
_p_vi() { [[ $KEYMAP == vicmd ]] && _vi='<' || _vi='>'; zle reset-prompt }
add-zle-hook-widget keymap-select _p_vi
add-zle-hook-widget line-init _p_vi

# timer for commands >= 5s
_p_preexec() { _t0=$EPOCHSECONDS }
_p_precmd() {
  local -i t=$(( EPOCHSECONDS - ${_t0:-EPOCHSECONDS} )); _t0= _dur= _vi='>'
  if (( t >= 5 )); then
    _dur=" %F{yellow}"; (( t >= 86400 )) && _dur+="$((t/86400))d "
    (( t >= 3600 )) && _dur+="$((t/3600%24))h "
    (( t >= 60 )) && _dur+="$((t/60%60))m "; _dur+="$((t%60))s%f"
  fi
  vcs_info
}
add-zsh-hook preexec _p_preexec
add-zsh-hook precmd _p_precmd

# git: * unstaged, + staged, ? untracked, ⇡⇣ ahead/behind, ≡ stash, (action)
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats ' %F{242}%b%f%F{218}%u%c%f%m'
zstyle ':vcs_info:git:*' actionformats ' %F{242}%b%f%F{218}%u%c%f%m %F{yellow}(%a)%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-extras
+vi-git-extras() {
  git ls-files -o --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' &>/dev/null && hook_com[unstaged]+='?'
  local -a c=( $(git rev-list --left-right --count 'HEAD...@{upstream}' 2>/dev/null) )
  (( c[1] )) && hook_com[misc]+=" %F{cyan}⇡$c[1]%f"
  (( c[2] )) && hook_com[misc]+=" %F{cyan}⇣$c[2]%f"
  git rev-parse -q --verify refs/stash &>/dev/null && hook_com[misc]+=' %F{cyan}≡%f'
  return 0
}

PROMPT='%(?.%F{blue}.%F{red})${_vi}%f %F{blue}%3~%f${vcs_info_msg_0_}${_dur} %# '

#### START DIRECTORY ####
cdc
