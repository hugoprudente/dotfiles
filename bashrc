# append to bash_history if Terminal.app quits
shopt -s histappend
ulimit -n 65536 200000
# erase duplicates; alternative option: export HISTCONTROL=ignoredups
export HISTCONTROL=${HISTCONTROL:-ignorespace:erasedups}

# resize history to 100x the default (500)
export HISTSIZE=${HISTSIZE:-50000}

# ignore comandos especificos no bash-history
export HISTIGNORE='ls:ls -lah:pwd:htop:top:clear:reset:exit:wpc5:sulu:git log:git status:cd ..'

# create a extra daily bash-history in case of bash_history fails. 
#export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'
export PROMPT_COMMAND='
  LAST_CMD_FILE="$HOME/.logs/.last_command"
  CURRENT_CMD="$(history 1 | awk "{print \$2}")"
  if [ "$(id -u)" -ne 0 ]; then
    if [ ! -f "$LAST_CMD_FILE" ] || [ "$CURRENT_CMD" != "$(cat "$LAST_CMD_FILE")" ]; then
      echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> "$HOME/.logs/bash-history-$(date "+%Y-%m-%d").log"
      echo "$CURRENT_CMD" > "$LAST_CMD_FILE"
    fi
  fi
'

# Use a decent blue on the directories for LS
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export BASH_SILENCE_DEPRECATION_WARNING=1

# Load the path first before find commands to source
export PATH="$HOME/bin:/opt/homebrew/bin:$PATH"

# start starship
if starship --version &> /dev/null;then
  eval "$(starship init bash)"
fi

if direnv --version &> /dev/null;then
  eval "$(direnv hook bash)"
fi

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# load my custom aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# for my OSX load the python3.x from venv
if [ -d "$HOME/Environments/osx" ];then
  source ~/Environments/osx/bin/activate
fi

if [ -d "$HOME/Environments/venv" ];then
  source ~/Environments/venv/bin/activate
fi

if [ -d "$HOME/Environments/wsl" ];then
  source ~/Environments/wsl/bin/activate
fi

# alias nvim as vim if using it
if [ -f "/usr/local/bin/nvim" ] | [ -f "/usr/bin/nvim" ] | [ -f "/opt/homebrew/bin/nvim" ];then
  alias vim="nvim"
  alias vi="nvim"
fi

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]]; then
  [ -z "$TMUX"  ] && { tmux attach || tmux new;}
fi

# Load bash-completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
elif [ -f "$(brew --prefix 2>/dev/null)/etc/profile.d/bash_completion.sh" ]; then
  . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi

# Kubernetes things
if [ $(command -v flux) ];then
  source <(flux completion bash)
fi
if [ $(command -v kubectl) ];then
  source <(kubectl completion bash)
fi

if [ $(command -v codium) ];then
  alias code="codium"
fi

# Linux things
if [ $(command -v funcoeszz ) ];then
  # # Instalacao das Funcoes ZZ (www.funcoeszz.net)
  export ZZOFF=""  # desligue funcoes indesejadas
  export ZZPATH="$HOME/bin/funcoeszz"  # script
  export ZZDIR=""    # pasta zz/
  source "$ZZPATH"
fi
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

if [ -d "${KREW_ROOT:-$HOME/.krew}" ]; then
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

if [ $(command -v argocd) ]; then
  export ARGOCD_OPTS="--port-forward --grpc-web --port-forward-namespace=sulu-argocd"
fi

if [ -f ~/.work.bashrc ]; then
  . ~/.work.bashrc
fi

if [ -f ~/.work.aliases ]; then
  . ~/.work.aliases
fi

cd $HOME
export PATH="$HOME/.local/bin:$PATH"
