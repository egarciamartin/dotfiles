# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=~/anaconda3/bin:$PATH
export PYTHONPATH="${PYTHONPATH}:/Users/eva/src/SDK_tooling/tutorials"
export PYTHONPATH="${PYTHONPATH}:/Users/eva/src"
export PYTHONPATH="${PYTHONPATH}:/Users/eva/src/research/"

export PATH=/Library/TeX/texbin:$PATH
export PATH=$HOME/.emacs.d/bin:$PATH

# (eval) error when autocompletion of pip
# alias pip=/Users/eva/anaconda3/bin/pip3

# Path to your oh-my-zsh installation.
export ZSH="/Users/eva/.oh-my-zsh"

alias yubion="ssh-add -s /usr/local/lib/opensc-pkcs11.so"
alias yubioff="ssh-add -e /usr/local/lib/opensc-pkcs11.so"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

ZSH_THEME="powerlevel10k/powerlevel10k"

# For emacs purposes:
# export TERM=xterm-24bit
alias emacs='emacs -nw'

# =============================================================================
#                                   Functions
# =============================================================================
function set_title(){
    echo -ne "\033];$(hostname): $(pwd)\007"
}
function mdToPDF()
{
    base=$(basename "$1" .md);
    pandoc -f markdown-implicit_figures --listings -H ~/.listings.tex -V geometry:"left=1.5cm, top=1.5cm, right=1.5cm, bottom=2.5cm" -V fontsize=12pt -o "$base.pdf" "$1";
}

# =============================================================================
#                                   Variables
# =============================================================================
# Pip MACOSX version
# export MACOSX_DEPLOYMENT_TARGET=11_0

# Common ENV variables
export TERM="xterm-256color"
export SHELL="/bin/zsh"
export EDITOR="vim"

# Fix Locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE


# color formatting for man pages
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;36m'     # begin blink
export LESS_TERMCAP_so=$'\e[1;33;44m'  # begin reverse video
export LESS_TERMCAP_us=$'\e[1;37m'     # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal

export MANPAGER='less -s -M -R +Gg'

# Directory coloring
if [[ $OSTYPE = (darwin|freebsd)* ]]; then
    #export CLICOLOR="YES" # Equivalent to passing -G to ls.
    #export LSCOLORS="exgxdHdHcxaHaHhBhDeaec"
    #export LS_OPTIONS='-G'
    export CLICOLOR=true
    export LSCOLORS='exfxcxdxbxGxDxabagacad'

fi

# Common aliases
alias rm="rm -v"
alias cp="cp -v"
alias mv="mv -v"
alias ls="ls $LS_OPTIONS -hFtr"
alias ll="ls $LS_OPTIONS -lAhFtr"
alias ccat="pygmentize -O style=monokai -f 256 -g"
alias dig="dig +nocmd any +multiline +noall +answer"


# =============================================================================
#                                   Plugins
# =============================================================================
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update
    zplug "zplug/zplug", hook-build:"zplug --self-manage"
fi
source ~/.zplug/init.zsh


zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
# # and sourcing other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# zplug "zsh-users/zsh-history-substring-search", defer:3

# =============================================================================
#                                   Options
# =============================================================================
function history() {
	#rg --smart-case --colors 'path:fg:yellow' --vimgrep -o '[^;]*$' ~/.zsh_history
	#rg --smart-case --vimgrep -p -o '[^;]*$' ~/.zsh_history
    rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" --vimgrep -o '[^;]*$' ~/.zsh_history
}



[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"



# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
source $ZSH/oh-my-zsh.sh


#
plugins=(
 git
 bundler
 dotenv
 osx
 rake
 rbenv
 ruby
 zsh-autosuggestions
 zsh-syntax-highlighting
 #pip
)


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/eva/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/eva/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/eva/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/eva/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
