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

# ==================== bash配置 ====================
set -o vi  # 在bash中使用vim方式移动光标

# ==================== 代理快捷开关 (mihomo) ====================
# 代理变量说明：
# 1. http_proxy / https_proxy / all_proxy 这几个名字表示“哪些请求默认走代理”，
#    不代表代理本身一定要分别写成 http / https 协议。
#    变量值里的协议头（如 http://、https://、socks5://、socks5h://）才表示“代理服务器类型”。
#
# 2. 例如：
#    http_proxy=socks5h://127.0.0.1:7890
#    https_proxy=socks5h://127.0.0.1:7890
#    表示访问 HTTP / HTTPS 资源时，都通过本地 SOCKS5 代理转发。
#    这是正常且常见的写法，并不要求 http_proxy 必须配 http://。
#
# 3. HTTP 代理与 SOCKS5 代理区别：
#    - HTTP/HTTPS 代理：主要面向 Web 请求，代理侧理解 HTTP / CONNECT。
#    - SOCKS5 代理：更通用，只负责转发 TCP 连接，不关心上层是 HTTP、HTTPS、SSH 还是其他协议。
#
# 4. socks5 与 socks5h 的区别：
#    - socks5://  表示域名通常先在本地解析，再把 IP 交给代理连接。
#    - socks5h:// 表示域名解析交给代理端完成，可减少 DNS 泄漏，通常更适合需要“全走代理”的场景。
#
# 5. 是否这样配置，取决于本地代理端口实际提供的协议：
#    - 如果 127.0.0.1:7890 是 SOCKS5 端口，就应写 socks5:// 或 socks5h://
#    - 如果 127.0.0.1:7890 是 HTTP 代理端口，就应写 http://
#    变量名不是关键，端口实际支持的代理协议才是关键。
#
# 6. 一些程序只认大写环境变量，实际使用时可同时设置：
#    HTTP_PROXY / HTTPS_PROXY / ALL_PROXY
#    以提高兼容性。


# 代理地址（你实测可用的配置，无需修改）
PROXY_URL="socks5h://127.0.0.1:7890"

# 主代理控制函数
proxy() {
    case "$1" in
        on)
            # 开启代理
            export http_proxy="$PROXY_URL"
            export https_proxy="$PROXY_URL"
            export all_proxy="$PROXY_URL"
            echo -e "\033[32m[✔] 代理已开启：$PROXY_URL\033[0m"
            ;;
        off)
            # 关闭代理
            unset http_proxy https_proxy all_proxy
            echo -e "\033[31m[✘] 代理已关闭\033[0m"
            ;;
        status)
            # 查看状态
            if [ -n "$all_proxy" ]; then
                echo -e "\033[32m[✔] 代理当前：开启\033[0m"
                echo "代理地址：$all_proxy"
            else
                echo -e "\033[31m[✘] 代理当前：关闭\033[0m"
            fi
            ;;
        *)
            # 帮助说明
            echo "用法："
            echo "  proxy on      - 开启代理"
            echo "  proxy off     - 关闭代理"
            echo "  proxy status  - 查看代理状态"
            echo "当前可用代理：$PROXY_URL"
            ;;
    esac
}


# ==================== opencode ====================
export OPENCODE_BIN="$HOME/.opencode/bin"
if [[ -e "$OPENCODE_BIN" ]]; then
    export PATH="$OPENCODE_BIN:$PATH"
fi

# ==================== bun ====================
export BUN_INSTALL="$HOME/.bun"
if [[ -e "$BUN_INSTALL" ]]; then
    export PATH="$BUN_INSTALL/bin:$PATH"
fi

# ==================== nvm ====================
export NVM_DIR="$HOME/.nvm"
if [[ -e "$NVIM_DIR" ]]; then
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

