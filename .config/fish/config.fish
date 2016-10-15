set -g t_black `tput setaf 0`
set -g t_red `tput setaf 1`
set -g t_green `tput setaf 2`
set -g t_yellow `tput setaf 3`
set -g t_blue `tput setaf 4`
set -g t_purple `tput setaf 5`
set -g t_cyan `tput setaf 6`
set -g t_white `tput setaf 7`
set -g t_bold `tput bold`
set -g t_reset `tput sgr0`
set -g t_underline `tput sgr 0 1`

function fish_prompt
    set -l git_branch (git branch ^/dev/null | sed -n '/\* /s///p')
    echo -n (tput setaf 3)(whoami)(tput setaf 1)'@'(tput setaf 6)''(hostname)':'(tput setaf 2)''(prompt_pwd)''(tput setaf 3)'{'"$git_branch"'} $ '
end
