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
set -o vi # 在bash中使用vim方式移动光标

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
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
fi

# ==================== 命令别名 ====================
alias nv='nvim'

# ======== 快速打开当前的common config文件 ========
open_config() {
  nvim $HOME/dotfiles/shell/.config/shell/common.sh
}

# ==============================
# fzf configuration
# ==============================

# 基础显示样式
export FZF_DEFAULT_OPTS="
  --height=80%
  --layout=reverse
  --border
  --info=inline
  --marker='+'
  --pointer='>'
  --prompt='fzf> '
  --bind='ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'
"

# 兼容 macOS 的 fd 和 Ubuntu 的 fdfind
if command -v fd >/dev/null 2>&1; then
  _fzf_fd_cmd="fd"
elif command -v fdfind >/dev/null 2>&1; then
  _fzf_fd_cmd="fdfind"
else
  _fzf_fd_cmd=""
fi

# 默认搜索命令：隐藏文件也搜，但排除常见垃圾目录
if [ -n "$_fzf_fd_cmd" ]; then
  export FZF_DEFAULT_COMMAND="$_fzf_fd_cmd --hidden --follow --exclude .git --exclude node_modules --exclude .venv --exclude __pycache__"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$_fzf_fd_cmd --type d --hidden --follow --exclude .git --exclude node_modules --exclude .venv --exclude __pycache__"
fi

# Ctrl-t：在当前命令行插入文件/目录路径
export FZF_CTRL_T_OPTS="
  --prompt='Path> '
  --preview '
    if [ -d {} ]; then
      command -v eza >/dev/null 2>&1 && eza -la --tree --level=2 {} || ls -la {};
    else
      command -v bat >/dev/null 2>&1 && bat --style=numbers --color=always --line-range=:300 {} || sed -n \"1,200p\" {};
    fi
  '
  --bind='ctrl-/:toggle-preview'
"

# Alt-c：模糊搜索目录并 cd 进去
export FZF_ALT_C_OPTS="
  --prompt='Cd> '
  --preview '
    command -v eza >/dev/null 2>&1 && eza -la --tree --level=2 {} || ls -la {}
  '
  --bind='ctrl-/:toggle-preview'
"

# Ctrl-r：模糊搜索历史命令
export FZF_CTRL_R_OPTS="
  --prompt='History> '
  --preview='echo {}'
  --preview-window=down:3:wrap
"

# ===== frpc wrapper =====

export FRPC_BIN="frpc"
export FRPC_CONF="$HOME/.config/frp/tmu.toml"
export FRPC_DIR="$HOME/.frpc"
export FRPC_LOG="$FRPC_DIR/frpc.log"
export FRPC_PID="$FRPC_DIR/frpc.pid"

frpc-start() {
  mkdir -p "$FRPC_DIR"

  if [ -f "$FRPC_PID" ]; then
    old_pid=$(cat "$FRPC_PID")
    if kill -0 "$old_pid" 2>/dev/null; then
      echo "frpc 已经在后台运行，PID: $old_pid"
      return 0
    else
      rm -f "$FRPC_PID"
    fi
  fi

  nohup "$FRPC_BIN" -c "$FRPC_CONF" >>"$FRPC_LOG" 2>&1 &
  echo $! >"$FRPC_PID"

  echo "frpc 已后台启动，PID: $(cat "$FRPC_PID")"
  echo "日志文件: $FRPC_LOG"
}

frpc-stop() {
  if [ ! -f "$FRPC_PID" ]; then
    echo "没有找到 frpc PID 文件，可能没有通过 frpc-start 启动。"
    return 1
  fi

  pid=$(cat "$FRPC_PID")

  if kill -0 "$pid" 2>/dev/null; then
    kill "$pid"
    rm -f "$FRPC_PID"
    echo "frpc 已关闭，PID: $pid"
  else
    rm -f "$FRPC_PID"
    echo "frpc 进程不存在，已清理 PID 文件。"
  fi
}


# ===== 快捷命令，用于将文件快速回传至本地机器 =====
# 需要开启反向隧道，并开启本地的ssh服务
tolocal() {
  scp -P 2222 "$1" rong@localhost:/tmp/
}


# ===== 快捷命令，快速赋予某个路径某个用户组权限 =====

shareperm() {
  local GROUP=""
  local TARGET=""
  local CREATE_GROUP=0
  local YES=0
  local DRY_RUN=0
  local FORCE=0
  local NO_ACL=0
  local CHANGED=0
  local BACKUP_DIR="${HOME}/.cache/shareperm"
  local BACKUP_FILE=""
  local USERS=()

  _sp_usage() {
    cat <<'EOF'
shareperm - 安全地把某个目录授权给指定用户组

用法：
  shareperm --group 组名 --path 路径 [选项]

必选参数：
  -g, --group GROUP       要授权的用户组
  -p, --path PATH         要处理的目录路径

可选参数：
  -u, --user USER         把某个用户加入该组，可重复使用
      --create-group      如果用户组不存在，则自动创建
      --no-acl            不设置 ACL，只设置 chgrp/chmod/setgid
      --dry-run           只显示将要执行的操作，不真正修改
  -y, --yes               跳过交互确认
      --force             允许处理高风险路径
  -h, --help              显示帮助

示例：
  shareperm --group research --path /data/project --create-group
  shareperm --group research --path /data/project --user zhangsan --create-group
  shareperm --group research --path /data/project --dry-run
EOF
  }

  _sp_die() {
    echo "[shareperm][错误] $*" >&2
    return 1
  }

  _sp_log() {
    echo "[shareperm] $*"
  }

  _sp_need_cmd() {
    command -v "$1" >/dev/null 2>&1 || {
      _sp_die "缺少命令：$1"
      return 1
    }
  }

  _sp_run() {
    if [[ "$DRY_RUN" -eq 1 ]]; then
      printf '[dry-run]'
      printf ' %s' "$@"
      printf '\n'
      return 0
    fi

    "$@"
  }

  _sp_rollback() {
    if [[ "$DRY_RUN" -eq 0 && "$CHANGED" -eq 1 && -n "$BACKUP_FILE" && -f "$BACKUP_FILE" && "$NO_ACL" -eq 0 ]]; then
      echo "[shareperm][警告] 操作失败，正在尝试回滚 ACL/权限快照..."
      if sudo setfacl --restore="$BACKUP_FILE"; then
        echo "[shareperm] 已尝试回滚。快照文件保留在：$BACKUP_FILE"
      else
        echo "[shareperm][警告] 自动回滚失败，请手动检查。快照文件：$BACKUP_FILE" >&2
      fi
    fi
  }

  _sp_run_or_rollback() {
    _sp_run "$@" || {
      local code=$?
      _sp_rollback
      return "$code"
    }
  }

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -g|--group)
        [[ -n "${2:-}" ]] || { _sp_die "--group 后面不能为空"; return 1; }
        GROUP="$2"
        shift 2
        ;;
      -p|--path)
        [[ -n "${2:-}" ]] || { _sp_die "--path 后面不能为空"; return 1; }
        TARGET="$2"
        shift 2
        ;;
      -u|--user)
        [[ -n "${2:-}" ]] || { _sp_die "--user 后面不能为空"; return 1; }
        USERS+=("$2")
        shift 2
        ;;
      --create-group)
        CREAT[118;1:3uE_GROUP=1
        shift
        ;;
      --no-acl)
        NO_ACL=1
        shift
        ;;
      --dry-run)
        DRY_RUN=1
        shift
        ;;
      -y|--yes)
        YES=1
        shift
        ;;
      --force)
        FORCE=1
        shift
        ;;
      -h|--help)
        _sp_usage
        return 0
        ;;
      *)
        _sp_die "未知参数：$1。使用 shareperm --help 查看帮助。"
        return 1
        ;;
    esac
  done

  [[ -n "$GROUP" ]] || { _sp_die "缺少参数：--group"; return 1; }
  [[ -n "$TARGET" ]] || { _sp_die "缺少参数：--path"; return 1; }

  _sp_need_cmd sudo || return 1
  _sp_need_cmd getent || return 1
  _sp_need_cmd chgrp || return 1
  _sp_need_cmd chmod || return 1
  _sp_need_cmd find || return 1
  _sp_need_cmd readlink || return 1
  _sp_need_cmd id || return 1

  if [[ "$NO_ACL" -eq 0 ]]; then
    if ! command -v setfacl >/dev/null 2>&1 || ! command -v getfacl >/dev/null 2>&1; then
      echo "[shareperm][错误] 未安装 ACL 工具。"
      echo "请先执行："
      echo "  sudo apt update && sudo apt install acl"
      return 1
    fi
  fi

  [[ -e "$TARGET" ]] || { _sp_die "路径不存在：$TARGET"; return 1; }
  [[ -d "$TARGET" ]] || { _sp_die "目标必须是目录：$TARGET"; return 1; }

  if [[ -L "$TARGET" && "$FORCE" -eq 0 ]]; then
    _sp_die "目标路径本身是符号链接，为避免误操作已拒绝。确实要处理请加 --force。"
    return 1
  fi

  TARGET="$(readlink -f -- "$TARGET")" || return 1

  case "$TARGET" in
    "/"|"/bin"|"/boot"|"/dev"|"/etc"|"/home"|"/lib"|"/lib64"|"/media"|"/mnt"|"/opt"|"/proc"|"/root"|"/run"|"/sbin"|"/srv"|"/sys"|"/tmp"|"/usr"|"/var")
      if [[ "$FORCE" -eq 0 ]]; then
        _sp_die "目标路径是高风险目录：$TARGET。如确实需要，请加 --force。"
        return 1
      fi
      ;;
  esac

  if [[ "$GROUP" =~ [[:space:]/:] ]]; then
    _sp_die "用户组名称包含非法字符：$GROUP"
    return 1
  fi

  local user
  for user in "${USERS[@]}"; do
    id "$user" >/dev/null 2>&1 || {
      _sp_die "用户不存在：$user"
      return 1
    }
  done

  if getent group "$GROUP" >/dev/null; then
    _sp_log "用户组已存在：$GROUP"
  else
    if [[ "$CREATE_GROUP" -eq 1 ]]; then
      _sp_log "用户组不存在，将创建：$GROUP"
      _sp_run sudo groupadd "$GROUP" || return 1
    else
      _sp_die "用户组不存在：$GROUP。可以先执行 sudo groupadd $GROUP，或加参数 --create-group。"
      return 1
    fi
  fi

  echo
  echo "即将执行以下操作："
  echo
  echo "  目标目录：$TARGET"
  echo "  授权用户组：$GROUP"
  echo "  是否创建组：$([[ "$CREATE_GROUP" -eq 1 ]] && echo "是" || echo "否")"
  echo "  是否设置 ACL：$([[ "$NO_ACL" -eq 0 ]] && echo "是" || echo "否")"
  echo "  是否 dry-run：$([[ "$DRY_RUN" -eq 1 ]] && echo "是" || echo "否")"
  echo
  echo "将执行："
  echo "  1. 将目录及其内容的所属组改为 $GROUP"
  echo "  2. 给组添加读写权限，目录添加进入权限"
  echo "  3. 给所有子目录设置 setgid，使新文件继承用户组"
  echo "  4. 设置默认 ACL，使新文件默认给 $GROUP 读写权限"
  echo "  5. 可选：把指定用户加入 $GROUP"
  echo

  if [[ "${#USERS[@]}" -gt 0 ]]; then
    echo "将加入该组的用户："
    for user in "${USERS[@]}"; do
      echo "  - $user"
    done
    echo
  fi

  if [[ "$YES" -eq 0 && "$DRY_RUN" -eq 0 ]]; then
    local answer
    printf "确认继续？请输入 yes： "
    IFS= read -r answer
    [[ "$answer" == "yes" ]] || {
      _sp_die "用户取消操作。"
      return 1
    }
  fi

  if [[ "$DRY_RUN" -eq 0 && "$NO_ACL" -eq 0 ]]; then
    mkdir -p "$BACKUP_DIR" || return 1

    local safe_name
    safe_name="$(echo "$TARGET" | sed 's#/#_#g' | sed 's#[^A-Za-z0-9_.-]#_#g')"
    BACKUP_FILE="${BACKUP_DIR}/${safe_name}_$(date +%Y%m%d_%H%M%S).acl"

    _sp_log "保存 ACL/权限快照：$BACKUP_FILE"
    sudo getfacl -R -p "$TARGET" > "$BACKUP_FILE" || return 1
  fi

  for user in "${USERS[@]}"; do
    _sp_log "将用户加入用户组：$user -> $GROUP"
    _sp_run sudo usermod -aG "$GROUP" "$user" || return 1
  done

  _sp_log "修改所属组：$GROUP"
  CHANGED=1
  _sp_run_or_rollback sudo chgrp -R "$GROUP" "$TARGET" || return 1

  _sp_log "给用户组添加读写权限，目录添加进入权限"
  _sp_run_or_rollback sudo chmod -R g+rwX "$TARGET" || return 1

  _sp_log "给所有目录设置 setgid，使新建文件继承用户组"
  _sp_run_or_rollback sudo find "$TARGET" -type d -exec chmod g+s {} + || return 1

  if [[ "$NO_ACL" -eq 0 ]]; then
    _sp_log "给现有文件和目录设置 ACL"
    _sp_run_or_rollback sudo setfacl -R -m "g:${GROUP}:rwX" "$TARGET" || return 1

    _sp_log "设置默认 ACL，使未来新建文件继承组权限"
    _sp_run_or_rollback sudo setfacl -R -d -m "g:${GROUP}:rwX" "$TARGET" || return 1
  fi

  echo
  echo "完成。"
  echo
  echo "目标目录："
  echo "  $TARGET"
  echo
  echo "用户组："
  echo "  $GROUP"
  echo
  echo "建议检查："
  echo "  ls -ld \"$TARGET\""
  echo "  getfacl \"$TARGET\""
  echo

  if [[ "${#USERS[@]}" -gt 0 ]]; then
    echo "注意："
    echo "  已加入用户组的用户需要重新登录后，组权限才会完全生效。"
    echo "  也可以让用户临时执行："
    echo "    newgrp $GROUP"
    echo
  fi

  if [[ -n "$BACKUP_FILE" && -f "$BACKUP_FILE" ]]; then
    echo "快照文件："
    echo "  $BACKUP_FILE"
    echo
    echo "如需手动恢复 ACL/权限快照，可执行："
    echo "  sudo setfacl --restore=\"$BACKUP_FILE\""
    echo
  fi
}
