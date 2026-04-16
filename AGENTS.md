# AGENTS.md

本文件为在此仓库中工作的代理、脚本协作者或后续维护者提供最小必要上下文。

## 仓库定位

这是一个个人 `dotfiles` 仓库，当前主要管理以下配置文件：

- `bash/.bashrc`
- `tmux/.tmux.conf`
- `git/.gitconfig`
- `README.md`
- `AGENTS.md`

仓库规模很小，没有独立的构建系统、测试框架或包管理配置。对本仓库的修改通常会直接影响用户登录 shell、tmux 行为或 git 使用体验，因此应优先做小步、可验证的变更。

## 当前结构

本仓库采用 **GNU Stow** 布局：

- `bash/`：`stow bash` 后部署为 `~/.bashrc`
- `tmux/`：`stow tmux` 后部署为 `~/.tmux.conf`
- `git/`：`stow git` 后部署为 `~/.gitconfig`
- `README.md`：仓库使用说明，不会部署到 `$HOME`
- `AGENTS.md`：协作说明，不会部署到 `$HOME`

package 内部路径应镜像目标路径。如果后续新增 `~/.config` 下的配置，请按类似 `package/.config/app/...` 的结构组织。

## 修改原则

- 保持改动尽量小，避免顺手重写整份 dotfile。
- 这是用户环境配置仓库，不能假设所有命令都可跨平台；新增配置前先考虑 Linux 与 macOS 差异。
- 若新增外部依赖、插件或命令，需在文件中留下足够明显的说明，并同步更新 `README.md`。
- 不要提交敏感信息，如 token、私钥、机器专属路径或仅适用于单台主机的凭据。
- 编辑 shell 配置时，尽量避免破坏非交互 shell；当前 `.bashrc` 已用 `case $- in *i*)` 做了交互式保护，应保留这一行为。
- 根目录文档不参与部署；只有各个 package 目录中的文件会被 `stow` 链接到 `$HOME`。

## 文件级注意事项

### `.bashrc`

- 当前配置明显偏向 Debian/Ubuntu 风格，包含 `/usr/share/bash-completion`、`/usr/bin/dircolors`、`lesspipe` 等路径。
- 已存在自定义 `PATH`：`/home/rongzw/.local/bin`。修改时注意这类路径可能是机器相关配置。
- 若新增 alias 或环境变量，优先放在文件底部自定义区域，避免打乱系统默认模板段落。

### `.tmux.conf`

- 当前依赖 TPM：`~/.tmux/plugins/tpm/tpm`
- 已启用插件：
  - `tmux-plugins/tpm`
  - `tmux-plugins/tmux-sensible`
  - `tmux-plugins/tmux-yank`
- 若改动快捷键，注意是否会与 tmux 默认键位或插件键位冲突。

### `.gitconfig`

- 包含真实姓名、邮箱和 `credential.helper=store`。如任务不要求，不要改动身份信息与凭据策略。
- alias 已较精简，新增 alias 时应与已有缩写风格保持一致。

## 推荐工作流

在这个仓库中工作时，优先使用以下流程：

1. 先阅读目标文件，不要凭 README 假设当前本机实际配置。
2. 做单文件、小范围修改。
3. 修改后执行对应的轻量验证命令，必要时用 `stow -n -v <package>` 做部署预演。
4. 若行为变化需要用户手动生效，在最终说明中明确告知如何 reload。

## 验证建议

本仓库没有自动化测试，通常使用下列方式做语法或加载验证：

- Bash 配置检查：`bash -n bash/.bashrc`
- Git 配置检查：`git config --file git/.gitconfig --list`
- tmux 配置检查：`tmux source-file tmux/.tmux.conf`
- Stow 预演：`stow -n -v bash git tmux`

注意：

- `tmux source-file .tmux.conf` 会作用于当前 tmux 环境；如果任务只要求静态检查，先说明这一点。
- 若你无法安全执行 reload 类命令，至少完成静态语法检查并在结论中说明未做运行时验证。

## 提交与说明

- 提交信息建议聚焦行为变化，例如：`feat: add tmux copy helper`、`fix: correct bare repo alias docs`
- 最终汇报时优先说明：
  - 改了什么
  - 为什么要这样改
  - 是否做了验证
  - 是否需要用户手动 reload

## 不该做的事

- 不要把整个 `$HOME` 目录视作当前仓库内容进行大范围扫描或批量改写。
- 不要把根目录文档误当作需要部署到 `$HOME` 的配置文件。
- 不要在未确认用户当前机器状态前，直接用 `stow` 覆盖已有的真实文件。
