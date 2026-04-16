# ======== 共享 Shell 配置 ========
# 先加载共用的 PATH、locale、代理和终端辅助逻辑，
# 这样后续插件与交互命令都能直接使用。
if [ -r "$HOME/.config/shell/common.sh" ]; then
  . "$HOME/.config/shell/common.sh"
fi

# ======== Oh My Zsh 核心配置 ========
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="random"
plugins=(git colorize zsh-autosuggestions zsh-syntax-highlighting)

if [ -r "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# ======== 个人说明 ========
# 当前主题由 Oh My Zsh 提供。
# 如果之后要切换到 starship，建议在框架加载完成后再初始化。
