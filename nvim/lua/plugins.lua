--  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .-----------------. .----------------.
-- | .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
-- | |   ______     | || |   _____      | || | _____  _____ | || |    ______    | || |     _____    | || | ____  _____  | || |    _______   | |
-- | |  |_   __ \   | || |  |_   _|     | || ||_   _||_   _|| || |  .' ___  |   | || |    |_   _|   | || ||_   \|_   _| | || |   /  ___  |  | |
-- | |    | |__) |  | || |    | |       | || |  | |    | |  | || | / .'   \_|   | || |      | |     | || |  |   \ | |   | || |  |  (__ \_|  | |
-- | |    |  ___/   | || |    | |   _   | || |  | '    ' |  | || | | |    ____  | || |      | |     | || |  | |\ \| |   | || |   '.___`-.   | |
-- | |   _| |_      | || |   _| |__/ |  | || |   \ `--' /   | || | \ `.___]  _| | || |     _| |_    | || | _| |_\   |_  | || |  |`\____) |  | |
-- | |  |_____|     | || |  |________|  | || |    `.__.'    | || |  `._____.'   | || |    |_____|   | || ||_____|\____| | || |  |_______.'  | |
-- | |              | || |              | || |              | || |              | || |              | || |              | || |              | |
-- | '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
--  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'
---@diagnostic disable
-- 所有插件在这里安装
-- 注意先安装插件管理器 Packer.nvim: 其只负责安装、升级、移除等功能，启用插件需要自己配置启用。
-- ！修改插件配置文件后，重新打开nvim，需要运行:PackerCompile才可以成功加载配置（只需要1次）
-- nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
-- docs: https://github.com/wbthomason/packer.nvim
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim';
local compile_path = install_path .. "/plugin/packer_compiled.lua";
local packer_bootstrap = nil;
if fn.empty(fn.glob(install_path)) > 0 then
  local args = {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  packer_bootstrap = fn.system(args);
  vim.cmd [[packadd packer.nvim]]
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                       Pakcer 插件列表 & 启动插件管理器                       │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
return require("packer").startup({
  function(use)
    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                        packer 包管理工具可以管理自己                         │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    use({ "wbthomason/packer.nvim" })

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                基础工具函数库                                │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    use({ "nvim-lua/plenary.nvim" })
    --
    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                   颜色主题                                   │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    -- use({"RRethy/nvim-base16"})
    -- use({
    --   "tanvirtin/monokai.nvim",
    --   config = [[require("plugin-configs.monokai")]]
    -- })
    use({
        "navarasu/onedark.nvim",
        config = function() require("plugin-configs.onedark") end,
    })

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                  文件图标                                    │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    use({
        "kyazdani42/nvim-web-devicons",
        config = function() require("plugin-configs.nvim-web-devicons") end,
    })

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                             which-key 快捷键菜单                             │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    use({
        "folke/which-key.nvim",
        commit = "6885b669523ff4238de99a7c653d47b081b5506d",
        config = function() require("plugin-configs.which-key") end,
    })

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                顶部 buffer 栏                                │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    use({
        "romgrk/barbar.nvim", requires = "kyazdani42/nvim-web-devicons",
        config = function() require("plugin-configs.barbar") end,
    })

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                  底部状态栏                                  │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    use({
        "feline-nvim/feline.nvim",
        config = function() require("plugin-configs.feline") end,
    })

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                               侧边栏文件目录树                               │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    -- 现在得用nvim-tree来替代kyazdani42了
    use({
        "kyazdani42/nvim-tree.lua",
        tag = "nightly",
        requires = "kyazdani42/nvim-web-devicons",
        config = function() require("plugin-configs.nvim-tree") end,
    })

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                     注释                                     │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    -- use({ "JoosepAlviste/nvim-ts-context-commentstring" })
    -- use({
    --   "b3nj5m1n/kommentary",
    --   config = [[require("plugin-configs.kommentary")]],
    -- })
    -- use({
    --   "LudoPinelli/comment-box.nvim",
    --   config = [[require("plugin-configs.comment-box")]],
    -- })
    use({
        'numToStr/Comment.nvim',
        config = function() require("plugin-configs.Comment") end,
    })

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                              自动输入匹配的括号                              │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    use({
      "windwp/nvim-autopairs",
      config = function() require("plugin-configs.nvim-autopairs") end,
    })

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                          更好的编程语言语法高亮支持                          │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local installer = loadModule("nvim-treesitter.install", "plugin-configs")
            installer.prefer_git = false
            installer.compilers = {"gcc", "clang"}
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        config = function() require("plugin-configs.nvim-treesitter") end,
    })
    -- treesitter的一个模块，其可以为嵌套的括号显示不同的颜色
    use({
      "p00f/nvim-ts-rainbow",
      requires = "nvim-treesitter/nvim-treesitter",
    })

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                     LSP/CMP: 代码提示/ 补全配置/ UI增强                      │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    -- nvim自带lsp功能，即其可以作为language server的客户端。
    use({ "neovim/nvim-lspconfig" })                 -- lspconfig 用于配置nvim的lsp功能，lsp需要自己安装
    use({ "williamboman/mason.nvim" })               -- LSP/DAP 服务器安装管理工具，这样lsp可以有统一的界面进行安装和管理
    use({ "williamboman/mason-lspconfig.nvim" })     -- LSP/DAP 服务器安装管理工具，用来链接mason和lspconfig之间的gap，比如名称的区别

    use({ "hrsh7th/cmp-nvim-lsp" })                  -- 使cmp可以利用到lsp中的source
    use({ "hrsh7th/cmp-vsnip" })                     -- 使cmp可以利用到vsnip中的source
    use({ "hrsh7th/cmp-buffer" })                    -- { name = 'buffer' },
    use({ "hrsh7th/cmp-path" })                      -- { name = 'path' }
    use({ "hrsh7th/cmp-cmdline" })                   -- { name = 'cmdline' }
    use({ "hrsh7th/nvim-cmp" })                      -- 补全引擎，nvim虽然能够作为客户端和LSP通讯，但是其没有自动补全（可以手动补全）
    use({ "hrsh7th/vim-vsnip" })                     -- vim-vsnip 插件，提供snippets
    -- use({ "hrsh7th/cmp-nvim-lsp-signature-help" })   -- { name = 'nvim_lsp_signature_help' }
    -- use({ "hrsh7th/cmp-nvim-lua" })                  -- { name = 'nvim_lua' }
    use({ "glepnir/lspsaga.nvim"})                   -- UI 增强，将诊断、定义跳转等展示方式进行了增强
    -- use({ "jose-elias-alvarez/null-ls.nvim" })       -- 多语言代码检查工具, 功能类似 ESLint
    use({ "rafamadriz/friendly-snippets" })          -- 常见编程语言 snippets


    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                 文件搜索                                     │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
      requires = { {'nvim-lua/plenary.nvim'} },
      config = function() require("plugin-configs.telescope") end,
      -- NOTE: 下面插件的配置都放在了telescope的配置中
    }
    -- 加快搜索速度
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    -- 路径(文件夹)搜索
    use {"nvim-telescope/telescope-file-browser.nvim"}

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                         加速启动时间 & 识别文件类型                          │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    use({
      "nathom/filetype.nvim",
      config = function() require("plugin-configs.filetype") end,
    })   

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                   缩进显示                                   │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    use({
      "lukas-reineke/indent-blankline.nvim",
      config = function() require("plugin-configs.indent_blankline") end,
    })

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                               颜色代码直接显示                               │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    use({
      "norcalli/nvim-colorizer.lua",
      config = function() require("colorizer").setup() end,
    })

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                 重复上述动作                                 │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯

    use({"tpope/vim-repeat"})  -- leap的重复需要用到

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                 快速移动插件                                 │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    -- leap是sneak-like的快速移动插件，我用easymotion用惯了。
    -- use({
    --   "ggandor/leap.nvim",
    --   requires = "tpope/vim-repeat",
    --   config = function() require("leap").add_default_mappings(true) end,
    -- })
    -- NOTE: leap在visual mode下会是x键失效，这是我常用的一个键（用来删除），所以还是转向了
    -- easymotion-like的插件（hop）
    use {
      'phaazon/hop.nvim',
      branch = 'v2', -- optional but strongly recommended
      config = function()
        require("plugin-configs.hop")
      end
    }

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                             两侧字符快速修改                                 │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    use({
      "kylechui/nvim-surround",
      tag = "*", -- Use for stability; omit to use `main` branch for the latest features
      config = function() require("nvim-surround").setup() end
    })

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                               TODO及其他标识                                 │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function() require("plugin-configs.todo_comments") end
    }

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                  启动页                                      │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    use {'glepnir/dashboard-nvim', config = function() require("plugin-configs.dashboard") end}
    

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                               session管理                                    │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    use({
      "olimorris/persisted.nvim",
      --module = "persisted", -- For lazy loading
      config = function() require("plugin-configs.persisted") end

    })

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                             vim内部的terminal                                │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    use({
      "akinsho/toggleterm.nvim", tag = '*',
      config = function() require("plugin-configs.toggleterm") end
    })

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                多光标操作                                    │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    -- TODO: 和原始键位设置存在冲突，且其无法修改，暂时不用了
    -- use({'mg979/vim-visual-multi', branch = "master",
    -- config = function()
    --   -- 取消所有的默认键位映射，只保留一个
    --   vim.opt.VM_default_mappings=0
    -- end})

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                 安装插件插件                                 │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    if packer_bootstrap then
      require('packer').sync()
    end
  end,

  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │                               Pakcer 插件配置                                │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
  config = {
    -- 编译路径
    compile_path = compile_path,

    -- 下载插件最大并发数
    max_jobs = 32,

    -- 不设置超时时间, 如果网速较慢, 设置为 true, 可能插件安装失败
    clone_timeout = false,

    -- Packer 显示面板
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                寻找想要的插件                                │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ https://vimawesome.com                                                       │
-- │ https://github.com/rockerBOO/awesome-neovim                                  │
-- │ https://github.com/altermo/vim-plugin-list                                   │
-- │ https://github.com/neovim/neovim/wiki/Related-projects#plugins               │
-- │ https://github.com/mhinz/vim-galore/blob/master/PLUGINS.md                   │
-- │ https://github.com/altermo/vim-plugin-list                                   │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
