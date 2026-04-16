# Dotfiles 管理（GNU Stow 方案）

本仓库现在采用 **GNU Stow** 管理个人配置文件。

和 bare repository 方案不同，这里使用一个普通 Git 仓库保存配置源文件，再通过 `stow` 在 `$HOME` 下创建符号链接。这样既能管理散落在家目录和 `~/.config` 中的配置，也能在仓库根目录保留 `README.md`、`AGENTS.md` 之类说明文档，而不会把它们部署到 `$HOME`。

## 仓库结构

当前目录按照“每个软件一个 package”的方式组织：

```text
dotfiles/
  README.md
  AGENTS.md
  bash/
    .bashrc
  git/
    .gitconfig
  tmux/
    .tmux.conf
```

规则是：

- 仓库根目录只放说明文档、脚本和元数据
- 每个一级目录都是一个 `stow package`
- package 内部的路径应当镜像目标路径

例如未来如果要管理 `~/.config/nvim/init.lua`，可以这样放：

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
stow -n -v bash git tmux
```

这一步不会真正创建链接，但能提前发现冲突。

### 3. 正式部署

```bash
stow bash git tmux
```

执行后会创建类似这些链接：

- `~/.bashrc -> ~/dotfiles/bash/.bashrc`
- `~/.gitconfig -> ~/dotfiles/git/.gitconfig`
- `~/.tmux.conf -> ~/dotfiles/tmux/.tmux.conf`

## 处理冲突

如果目标位置已经存在同名真实文件，`stow` 会报冲突。推荐先手动备份：

```bash
mkdir -p ~/.dotfiles-backup
mv ~/.bashrc ~/.dotfiles-backup/
mv ~/.gitconfig ~/.dotfiles-backup/
mv ~/.tmux.conf ~/.dotfiles-backup/
```

然后重新执行：

```bash
stow bash git tmux
```

## 日常使用

修改配置时，直接编辑仓库中的源文件：

```bash
cd ~/dotfiles
$EDITOR bash/.bashrc
$EDITOR git/.gitconfig
$EDITOR tmux/.tmux.conf
```

常用命令：

| 动作 | 命令 |
| :--- | :--- |
| 模拟安装 | `stow -n -v bash git tmux` |
| 安装 package | `stow bash` |
| 安装多个 package | `stow bash git tmux` |
| 重新整理链接 | `stow -R bash` |
| 卸载 package | `stow -D bash` |

## 修改后验证

本仓库目前没有自动化测试，建议至少做轻量验证：

```bash
bash -n bash/.bashrc
git config --file git/.gitconfig --list
tmux source-file tmux/.tmux.conf
```

如果改动影响当前会话，还需要手动 reload：

```bash
source ~/.bashrc
tmux source-file ~/.tmux.conf
```

## 注意事项

1. 不要把私钥、token、密码等敏感文件直接纳入仓库。
2. 当前 `.bashrc` 含有明显的 Linux 路径和机器相关配置，跨平台改动前要先确认环境差异。
3. `stow` 适合管理会部署到 `$HOME` 的配置文件；仓库根目录下的说明文件不会自动部署。
