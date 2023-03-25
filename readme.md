## NEOVIM

### requirements

1. [neovim](https://github.com/neovim/neovim/releases/tag/stable) 0.8+

2. [node, npm](https://nodejs.org/en/download)，设置国内镜像

  ```bash
  # taobao
  npm config set registry https://registry.npmmirror.com
  # 验证（返回http://mirrors.cloud.tencent.com/npm/）
  npm config get registry
  ```
3. make, gcc

4. [ripgrep](https://github.com/BurntSushi/ripgrep)

   ```bash
   sudo apt-get install ripgrep
   ```

5. [fd](https://github.com/sharkdp/fd)

  ```bash
  sudo apt install fd-find
  ```

6. 连接VPN

  ```bash
  clash
  # 打开"设置"中的代理
  proxy
  curl google.com  # 测试一下连接VPN是否成功
  ```

### install

1. 下载dotfiles库

```bash
git clone https://github.com/luyiyun/dotfiles.git
```

2. 建立库中nvim到config路径下的软链接

```bash
ln -s /path/dotfiles/nvim ~/.config/nvim
```

3. 安装nerd font

  ```bash
  # 1. 下载字体文件 (https://www.nerdfonts.com/font-downloads)
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip
  # 2. 安装字体
  sudo unzip FiraCode.zip /usr/share/fonts/
  # 3. 刷新字体缓存
  sudo fc-cache -fv
  # 4. 重启终端。进入终端的设置中，将字体改为firacode即可。
  ```

4. 打开nvim，进行插件的安装。多按几次I(安装)把出错的插件都安装完。

5. 关闭VPN设置

  ```bash
  unclash
  # 关闭"设置"中的代理
  unproxy
  ```
