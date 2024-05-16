# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# append to the history file, don't overwrite it
# shopt -s histappend
setopt  histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# lsがカラー表示になるようエイリアスを設定
case "${OSTYPE}" in
darwin*)
  # Mac
  alias ls="ls -GF"
  ;;
esac

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi


# linuxbrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# starship
eval "$(starship init zsh)"

# zsh-autosuggestionsを起動
. /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit colors
  compinit
  colors
fi

# completionsで警告が表示されたら実行する
#   chmod go-w '/home/linuxbrew/.linuxbrew/share'
#   chmod -R go-w '/home/linuxbrew/.linuxbrew/share/zsh'

# zsh-syntax-highlightingを起動
. /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
typeset -A ZSH_HIGHLIGHT_STYLES

# pathの下線を消す
ZSH_HIGHLIGHT_STYLES[path]="none"  # "none" -> "underline"


# hightlightでエラーが出たら実行
# export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/highlighters

# 履歴ファイルを明示
HISTFILE=~/.zsh_history

# ビープ音を鳴らさない
setopt nolistbeep

# コマンドのスペルミスを指摘する
setopt correct

# パターンにマッチしなかった場合にエラーを出さない
setopt no_nomatch

# 日本語の文字化け防止
export LANG=ja_JP.UTF-8

# プロンプト複数起動時のhistory共有
setopt share_history

# 重複するコマンドのhistory削除
setopt hist_ignore_all_dups

# 単語の入力途中でもTab補完を有効化
setopt complete_in_word

# 補完候補をハイライト
zstyle ':completion:*:default' menu select=1

# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true

# 大文字、小文字を区別せず補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完リストの表示間隔を狭くする
setopt list_packed

# 補完に関するオプション
# http://voidy21.hatenablog.jp/entry/20090902/1251918174
setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加

# コマンド実行後に1行空ける
add_newline() {
    if [[ -z $PS1_NEWLINE_LOGIN ]]; then
        PS1_NEWLINE_LOGIN=true
    else
        printf '\n'
    fi
}











eval "$(ssh-agent -s)"

# ssh-agent
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env
# ssh-agent

