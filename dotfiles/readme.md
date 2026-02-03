# 🚀 Dotfiles 管理 (Git Bare Repository 方案)

本仓库使用 **Git Bare Repository** 方法管理个人配置文件。这种方法无需软链接（Symbolic Links），直接将 `$HOME` 目录作为工作树，同时将 Git 记录保存在独立的目录中（`~/dotfiles`），从而保持根目录整洁。

## 🛠 核心配置说明

*   **仓库路径 (Git Dir):** `$HOME/dotfiles`
*   **工作空间 (Work Tree):** `$HOME`
*   **管理别名 (Alias):** `config`

---

## 📥 在新服务器上部署

当你登录一台从未配置过的新服务器时，执行以下步骤：

### 1. 克隆仓库并设置别名
```bash
# 克隆裸仓库到本地 dotfiles 文件夹
git clone --bare <你的仓库URL> $HOME/dotfiles

# 定义临时别名（用于当前会话执行后续命令）
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
```

### 2. 检出配置文件
```bash
# 尝试检出文件
config checkout
```

> **⚠️ 注意：** 如果报错提示 `The following untracked working tree files would be overwritten by checkout`，说明服务器已存在同名配置文件（如默认的 `.bashrc`）。
> 
> **解决方法：** 备份并删除冲突文件，或者强制覆盖：
> ```bash
> mkdir -p .dotfiles-backup
> # 将冲突的文件移动到备份目录，然后重新 checkout
> config checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/
> config checkout
> ```

### 3. 隐藏未跟踪文件 (非常重要)
为了避免 `config status` 显示整个 Home 目录下的所有非配置文件，必须关闭“显示未跟踪文件”：
```bash
config config --local status.showUntrackedFiles no
```

### 4. 永久保存别名
确保你的 `.bashrc` 或 `.zshrc` 中包含该别名：
```bash
echo "alias config='/usr/bin/git --git-dir=\$HOME/dotfiles/ --work-tree=\$HOME'" >> ~/.bashrc
source ~/.bashrc
```

---

## 📝 日常操作指南

使用 `config` 命令代替 `git` 命令来管理你的配置文件：

| 动作 | 命令 |
| :--- | :--- |
| **查看修改状态** | `config status` |
| **添加配置文件** | `config add .tmux.conf` |
| **提交修改** | `config commit -m "Update tmux config"` |
| **推送至远程** | `config push` |
| **拉取远程更新** | `config pull` |
| **查看所有已管辖文件** | `config ls-tree -r main --name-only` |

---

## 💡 提醒与注意事项

1.  **敏感信息**：切勿将包含 API Key、密码、私钥的文件（如 `.ssh/id_rsa`）添加到此仓库！建议配合 `.gitignore` 或手动 `add`。
2.  **环境变量**：在修改 `.bashrc` 或 `.tmux.conf` 后，记得运行 `source ~/.bashrc` 或 `tmux source ~/.tmux.conf` 以立即生效。
3.  **多平台差异**：如果不同服务器（如 Mac vs Linux）需要不同的配置，建议在配置文件内部使用条件判断，或者利用 Git 分支（`linux-branch` / `mac-branch`）。

---

## 📦 包含的软件配置
*   [x] **Tmux**: `vimmode`, `clipboard-sync`
*   [x] **Bash/Zsh**: `aliases`, `prompt`
*   [x] **git**: `aliases`, `email`

---

### 快速初始化新环境 (One-liner)
```bash
git clone --bare <你的仓库URL> $HOME/dotfiles && alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' && config checkout
```
