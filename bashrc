# append to bash_history if Terminal.app quits
shopt -s histappend

# erase duplicates; alternative option: export HISTCONTROL=ignoredups
export HISTCONTROL=${HISTCONTROL:-ignorespace:erasedups}

# resize history to 100x the default (500)
export HISTSIZE=${HISTSIZE:-50000}

# ignore comandos especificos no bash-history
export HISTIGNORE='ls:ls -lah:pwd:htop:top:clear:reset'

# create a extra daily bash-history in case of bash_history fails. 
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

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
if [ -f "/usr/local/bin/nvim" ] | [ -f "/usr/bin/nvim" ];then
  alias vim="nvim"
  alias vi="nvim"
fi

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]]; then
  [ -z "$TMUX"  ] && { tmux attach || tmux new;}
fi

# Use a decent blue on the directories for LS
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export BASH_SILENCE_DEPRECATION_WARNING=1

export PATH="$HOME/bin:$PATH"

source <(flux completion bash)
source <(kubectl completion bash)

# Instalacao das Funcoes ZZ (www.funcoeszz.net)
export ZZOFF=""  # desligue funcoes indesejadas
export ZZPATH="$HOME/bin/funcoeszz"  # script
export ZZDIR=""    # pasta zz/
source "$ZZPATH"
