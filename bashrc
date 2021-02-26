# Preferred editor for local and remote sessions

# BASH HISTORY

# append to bash_history if Terminal.app quits
shopt -s histappend

# erase duplicates; alternative option: export HISTCONTROL=ignoredups
export HISTCONTROL=${HISTCONTROL:-ignorespace:erasedups}

# resize history to 100x the default (500)
export HISTSIZE=${HISTSIZE:-50000}

# create a extra daily bash-history in case of bash_history fails. 
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

# start starship
if starship --version &> /dev/null;then
  eval "$(starship init bash)"
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

# alias nvim as vim if using it
if [ -f "/usr/local/bin/nvim" ];then
  alias vim="nvim"
  alias vi="nvim"
fi

export PATH="$HOME/bin:$PATH"
