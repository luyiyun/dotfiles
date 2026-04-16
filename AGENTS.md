# AGENTS.md

本文件为在此仓库中工作的代理、脚本协作者或后续维护者提供最小必要上下文。

## 仓库定位

这是一个个人 `dotfiles` 仓库，当前主要管理以下配置文件：

- `.bashrc`
- `.tmux.conf`
- `.gitconfig`
- `readme.md`

仓库规模很小，没有独立的构建系统、测试框架或包管理配置。对本仓库的修改通常会直接影响用户登录 shell、tmux 行为或 git 使用体验，因此应优先做小步、可验证的变更。

## 当前结构

顶层文件说明：

- `.bashrc`：Bash 交互式 shell 配置，包含历史记录、提示符、补全、别名与 `PATH` 设置。
- `.tmux.conf`：tmux 行为配置，启用 `vi` 风格复制模式，并依赖 TPM 插件。
- `.gitconfig`：git 用户信息、credential helper 和常用 alias。
- `readme.md`：说明如何用 bare repository 管理 home 目录配置文件。

## 重要约定与已知差异

有一个需要特别注意的现实差异：

- `readme.md` 中描述的 bare repository 路径是 `$HOME/dotfiles`
- `.bashrc` 中 `config` alias 实际指向的是 `git --git-dir=$HOME/.cfg/ --work-tree=$HOME`

在没有先和用户确认前，不要擅自统一这两个约定中的任意一个。若你的任务涉及 README、初始化脚本或 alias，请先判断目标是“修正文档”还是“修正本地实际配置”。

## 修改原则

- 保持改动尽量小，避免顺手重写整份 dotfile。
- 这是用户环境配置仓库，不能假设所有命令都可跨平台；新增配置前先考虑 Linux 与 macOS 差异。
- 若新增外部依赖、插件或命令，需在文件中留下足够明显的说明，并同步更新 `readme.md`。
- 不要提交敏感信息，如 token、私钥、机器专属路径或仅适用于单台主机的凭据。
- 编辑 shell 配置时，尽量避免破坏非交互 shell；当前 `.bashrc` 已用 `case $- in *i*)` 做了交互式保护，应保留这一行为。

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
3. 修改后执行对应的轻量验证命令。
4. 若行为变化需要用户手动生效，在最终说明中明确告知如何 reload。

## 验证建议

本仓库没有自动化测试，通常使用下列方式做语法或加载验证：

- Bash 配置检查：`bash -n .bashrc`
- Git 配置检查：`git config --file .gitconfig --list`
- tmux 配置检查：`tmux source-file .tmux.conf`

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
- 不要根据 README 直接执行 bare-repo checkout、覆盖用户 home 目录文件，除非用户明确要求。
- 不要在未确认的情况下把 README 与 `.bashrc` 中的 bare-repo 路径差异“顺手修掉”。
