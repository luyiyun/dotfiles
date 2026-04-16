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

如果未来还要管理 `~/.config/nvim/init.lua`，可以这样放：

```text
nvim/
  .config/
    nvim/
      init.lua
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
stow -n -v shell bash zsh git tmux
```

这一步不会真正创建链接，但能提前发现冲突。

### 3. 正式部署

```bash
stow shell bash zsh git tmux
```

执行后会创建类似这些链接：

- `~/.config/shell/common.sh -> ~/dotfiles/shell/.config/shell/common.sh`
- `~/.bashrc -> ~/dotfiles/bash/.bashrc`
- `~/.zshrc -> ~/dotfiles/zsh/.zshrc`
- `~/.gitconfig -> ~/dotfiles/git/.gitconfig`
- `~/.tmux.conf -> ~/dotfiles/tmux/.tmux.conf`

## 处理冲突

如果目标位置已经存在同名真实文件，`stow` 会报冲突。推荐先手动备份：

```bash
mkdir -p ~/.dotfiles-backup
mv ~/.bashrc ~/.dotfiles-backup/
mv ~/.zshrc ~/.dotfiles-backup/
mv ~/.gitconfig ~/.dotfiles-backup/
mv ~/.tmux.conf ~/.dotfiles-backup/
```

然后重新执行：

```bash
stow shell bash zsh git tmux
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
```

常用命令：

| 动作 | 命令 |
| :--- | :--- |
| 模拟安装 | `stow -n -v shell bash zsh git tmux` |
| 安装共享 shell 配置 | `stow shell` |
| 安装 package | `stow bash` |
| 安装多个 package | `stow shell bash zsh git tmux` |
| 重新整理链接 | `stow -R bash` |
| 卸载 package | `stow -D bash` |

## 修改后验证

本仓库目前没有自动化测试，建议至少做轻量验证：

```bash
bash -n bash/.bashrc
sh -n shell/.config/shell/common.sh
zsh -n zsh/.zshrc
git config --file git/.gitconfig --list
tmux source-file tmux/.tmux.conf
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
