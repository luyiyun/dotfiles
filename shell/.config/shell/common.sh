# ======== 共享 Shell 环境 ========
# 本文件会被 Bash 和 Zsh 同时加载，用来放两者共用的设置。

# 统一追加用户本地可执行文件目录，避免重复写入 PATH。
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$HOME/.local/bin:$PATH" ;;
esac

# 统一使用 UTF-8 locale，减少终端中中文显示异常的问题。
export LANG="zh_CN.UTF-8"
export LC_ALL="zh_CN.UTF-8"

# 在 tmux 内优先使用 tmux 专用的 TERM；
# 如果当前不在 tmux 中，则仅在 TERM 缺失时设置默认值。
if [ -n "${TMUX:-}" ]; then
  export TERM="tmux-256color"
elif [ -z "${TERM:-}" ]; then
  export TERM="xterm-256color"
fi

# ======== 共享 Shell 辅助函数 ========
# 为当前 shell 会话快速开启本地代理。
proxy() {
  export http_proxy="http://127.0.0.1:7890"
  export https_proxy="http://127.0.0.1:7890"
  export all_proxy="socks5://127.0.0.1:7890"
  export no_proxy="localhost,127.0.0.1,::1,*.local"
  echo "Proxy ON (127.0.0.1:7890)"
}

# 为当前 shell 会话关闭代理。
noproxy() {
  unset http_proxy https_proxy all_proxy no_proxy
  echo "Proxy OFF"
}
