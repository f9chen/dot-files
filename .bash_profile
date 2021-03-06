readonly UNAME_LINUX="Linux"
readonly UNAME_MAC="Darwin"

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

function parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Only apply to interactive shells
if [[ $- == *i* ]]; then
  # Text Colors
  t_black=$(tput setaf 0)
  t_red=$(tput setaf 1)
  t_green=$(tput setaf 2)
  t_yellow=$(tput setaf 3)
  t_blue=$(tput setaf 4)
  t_purple=$(tput setaf 5)
  t_cyan=$(tput setaf 6)
  t_white=$(tput setaf 7)

  # Background Colors
  b_black=$(tput setab 0)
  b_red=$(tput setab 1)
  b_green=$(tput setab 2)
  b_yellow=$(tput setab 3)
  b_blue=$(tput setab 4)
  b_purple=$(tput setab 5)
  b_cyan=$(tput setab 6)
  b_white=$(tput setab 7)

  # Other styles
  t_bold=$(tput bold)
  t_reset=$(tput sgr0)
  t_underline=$(tput sgr 0 1)

  export PS1="\[$t_bold\]\[$t_yellow\]\u@\h\[$t_red\]\w\\[$t_green\]\$(parse_git_branch)\[$t_red\]$ \[$t_reset\]"
fi

# Linux-specific Configs
if [ $(uname -s) = $UNAME_LINUX ]; then
  alias ls='ls --color=auto'

  # Prevent suspending the terminal
  stty ixany
  stty ixoff -ixon
fi

# Mac-specific Configs
if [ $(uname -s) = $UNAME_MAC ]; then
  alias ls='ls -G'
fi

# Set TERM
export TERM='xterm-256color'
[ -n "$TMUX" ] && export TERM=screen-256color

# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Source optional configs, if they exist
[ -f ~/.profile_aliases ] && source ~/.profile_aliases
