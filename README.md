# Dotfiles 管理（GNU Stow 方案）

本仓库现在采用 **GNU Stow** 管理个人配置文件。

和 bare repository 方案不同，这里使用一个普通 Git 仓库保存配置源文件，再通过 `stow` 在 `$HOME` 下创建符号链接。这样既能管理散落在家目录和 `~/.config` 中的配置，也能在仓库根目录保留 `README.md`、`AGENTS.md` 之类说明文档，而不会把它们部署到 `$HOME`。

## 仓库结构

当前目录按照“每个软件一个 package”的方式组织：

```text
dotfiles/
  README.md
  AGENTS.md
  shell/
    .config/
      shell/
        common.sh
  bash/
    .bashrc
  zsh/
    .zshrc
  git/
    .gitconfig
  tmux/
    .tmux.conf
  nvim/
    .config/
      nvim/
        init.lua
        lua/
        lazy-lock.json
```

规则是：

- 仓库根目录只放说明文档、脚本和元数据
- 每个一级目录都是一个 `stow package`
- package 内部的路径应当镜像目标路径

例如现在仓库里的共享 shell 配置就是这样组织的：

```text
shell/
  .config/
    shell/
      common.sh
```

`bash/.bashrc` 和 `zsh/.zshrc` 都会 source `~/.config/shell/common.sh`，这样 PATH、代理、locale、tmux 相关环境变量只需要维护一份。

Neovim 配置也按同样规则组织：

```text
nvim/
  .config/
    nvim/
      init.lua
      lua/
      lazy-lock.json
```

## 依赖

先确保系统安装了 `stow`。

常见安装方式：

```bash
# macOS (Homebrew)
brew install stow

# Debian / Ubuntu
sudo apt-get update
sudo apt-get install -y stow
```

## 在新机器上部署

### 1. 克隆仓库

```bash
git clone git@github.com:luyiyun/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. 先模拟一次

```bash
stow -n -v shell bash zsh git tmux nvim
```

这一步不会真正创建链接，但能提前发现冲突。

### 3. 正式部署

```bash
stow shell bash zsh git tmux nvim
```

执行后会创建类似这些链接：

- `~/.config/shell/common.sh -> ~/dotfiles/shell/.config/shell/common.sh`
- `~/.bashrc -> ~/dotfiles/bash/.bashrc`
- `~/.zshrc -> ~/dotfiles/zsh/.zshrc`
- `~/.gitconfig -> ~/dotfiles/git/.gitconfig`
- `~/.tmux.conf -> ~/dotfiles/tmux/.tmux.conf`
- `~/.config/nvim -> ~/dotfiles/nvim/.config/nvim`

## 处理冲突

如果目标位置已经存在同名真实文件，`stow` 会报冲突。推荐先手动备份：

```bash
mkdir -p ~/.dotfiles-backup
mv ~/.bashrc ~/.dotfiles-backup/
mv ~/.zshrc ~/.dotfiles-backup/
mv ~/.gitconfig ~/.dotfiles-backup/
mv ~/.tmux.conf ~/.dotfiles-backup/
mv ~/.config/nvim ~/.dotfiles-backup/nvim
```

然后重新执行：

```bash
stow shell bash zsh git tmux nvim
```

## 日常使用

修改配置时，直接编辑仓库中的源文件：

```bash
cd ~/dotfiles
$EDITOR bash/.bashrc
$EDITOR shell/.config/shell/common.sh
$EDITOR zsh/.zshrc
$EDITOR git/.gitconfig
$EDITOR tmux/.tmux.conf
$EDITOR nvim/.config/nvim/init.lua
```

常用命令：

| 动作 | 命令 |
| :--- | :--- |
| 模拟安装 | `stow -n -v shell bash zsh git tmux nvim` |
| 安装共享 shell 配置 | `stow shell` |
| 安装 package | `stow bash` |
| 安装多个 package | `stow shell bash zsh git tmux nvim` |
| 重新整理链接 | `stow -R bash` |
| 卸载 package | `stow -D bash` |

## 如何将新的配置纳入 dotfiles 管理

假设要新增的软件配置位于 `$HOME` 下，例如：

- 单文件：`~/.foo`
- 配置目录：`~/.config/foo`

推荐流程是先把真实配置移动到仓库中，再用 `stow` 建立符号链接。

### 1. 确认目标路径

先确认要管理的是配置源文件，而不是缓存、状态或运行时数据：

```bash
ls -la ~/.config/foo
```

不要把 token、私钥、机器专属凭据、缓存目录或自动生成的大型数据目录纳入仓库。

### 2. 创建对应 package 目录

package 内部路径要镜像 `$HOME` 下的目标路径。

如果要管理 `~/.config/foo`：

```bash
cd ~/dotfiles
mkdir -p foo/.config
mv ~/.config/foo foo/.config/foo
```

如果要管理 `~/.foo`：

```bash
cd ~/dotfiles
mkdir -p foo
mv ~/.foo foo/.foo
```

### 3. 预演 Stow

```bash
stow -n -v foo
```

如果预演出现冲突，先检查 `$HOME` 下是否已经存在同名真实文件或目录，不要直接覆盖。

### 4. 正式启用

```bash
stow foo
```

完成后，目标位置应该变成指向仓库的符号链接：

```bash
ls -la ~/.config/foo
```

### 5. 更新文档并纳入 Git

新增 package 后，建议同步更新本文档里的仓库结构、部署命令和验证命令。

```bash
git status
git add foo README.md
git commit -m "feat: add foo config"
```

## 如何去除 dotfiles 管理

根据目的不同，有两种常见做法。

### 只取消当前机器上的符号链接

如果只是想让当前机器暂时不再链接某个 package，但仓库里仍保留配置：

```bash
cd ~/dotfiles
stow -D foo
```

这会移除 `stow foo` 创建的符号链接，但不会删除仓库中的 `foo/` package。

### 保留真实配置，并从仓库中移除

如果想彻底不再用 dotfiles 管理某个配置，推荐先卸载链接，再把配置复制回 `$HOME`，最后再删除仓库 package。

以 `~/.config/foo` 为例：

```bash
cd ~/dotfiles
stow -D foo
mkdir -p ~/.config
cp -R foo/.config/foo ~/.config/foo
git rm -r foo
```

以 `~/.foo` 为例：

```bash
cd ~/dotfiles
stow -D foo
cp foo/.foo ~/.foo
git rm -r foo
```

然后同步更新 README，并提交：

```bash
git add README.md
git commit -m "chore: remove foo config"
```

提交前建议确认 `$HOME` 下的真实配置已经恢复：

```bash
ls -la ~/.config/foo
```

## 修改后验证

本仓库目前没有自动化测试，建议至少做轻量验证：

```bash
bash -n bash/.bashrc
sh -n shell/.config/shell/common.sh
zsh -n zsh/.zshrc
git config --file git/.gitconfig --list
tmux source-file tmux/.tmux.conf
nvim --headless +qa
```

如果改动影响当前会话，还需要手动 reload：

```bash
source ~/.bashrc
source ~/.zshrc
tmux source-file ~/.tmux.conf
```

## 注意事项

1. 不要把私钥、token、密码等敏感文件直接纳入仓库。
2. 共享 shell 逻辑统一放在 `shell/.config/shell/common.sh`，只有 Bash 或 Zsh 专属的行为再分别写进各自配置文件。
3. 当前 shell 配置包含代理、locale 和终端类型设置，变更前最好确认目标机器是否需要相同策略。
4. `stow` 适合管理会部署到 `$HOME` 的配置文件；仓库根目录下的说明文件不会自动部署。
5. Neovim 的运行时数据、状态和缓存目录通常位于 `~/.local/share/nvim`、`~/.local/state/nvim` 和 `~/.cache/nvim`，不应纳入本仓库。
