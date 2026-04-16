# ======== 交互式 Shell 保护 ========
# 非交互式 shell 直接返回，避免影响脚本执行。
case $- in
  *i*) ;;
  *) return ;;
esac

# ======== 历史记录与基础行为 ========
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend
shopt -s checkwinsize

# ======== 基础环境辅助 ========
# 如果系统提供 lesspipe，则增强 less 对非文本文件的处理。
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# 在 Debian chroot 环境中保留对应的提示信息。
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# ======== 提示符 ========
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes ;;
esac

if [ -n "${force_color_prompt:-}" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >/dev/null 2>&1; then
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
esac

# ======== 颜色与常用别名 ========
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# ======== 可选的本地 Bash 别名 ========
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# ======== Bash 自动补全 ========
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ======== 共享 Shell 配置 ========
# 共用设置放在 ~/.config/shell/common.sh 中，
# 这样 Bash 和 Zsh 可以复用同一份 PATH、locale、代理和终端辅助逻辑。
if [ -r "$HOME/.config/shell/common.sh" ]; then
  . "$HOME/.config/shell/common.sh"
fi
