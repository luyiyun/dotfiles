# ======== Powerlevel10k 配置 ========
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ======== 共享 Shell 配置 ========
# 先加载共用的 PATH、locale、代理和终端辅助逻辑，
# 这样后续插件与交互命令都能直接使用。
if [ -r "$HOME/.config/shell/common.sh" ]; then
  . "$HOME/.config/shell/common.sh"
fi

# ======== Oh My Zsh 核心配置 ========
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git colorize zsh-autosuggestions zsh-syntax-highlighting)

if [ -r "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# ======== 个人说明 ========
# 当前主题由 Oh My Zsh 提供。
# 如果之后要切换到 starship，建议在框架加载完成后再初始化。


# ======== fzf 配置 (主要配置在common.sh中) ========
# 启用 fzf zsh integration
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi
