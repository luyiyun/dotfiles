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
--  使用lazy.nvim来管理插件，有lazy loading的属性
--  NOTE: 需要在此之前配置leader map，保证快捷键映射的准确性
--  安装lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup(
  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │                                 lazy 插件列表                                │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
  {
    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                   工具类                                     │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    -- 方便使用的函数库，很多库的依赖
    -- NOTE: 只存在于dependencies中的插件将进行lazy load
    -- { "nvim-lua/plenary.nvim" },

    -- -----------------------------
    -- -加速启动时间 & 识别文件类型-
    -- -----------------------------
    {
      "nathom/filetype.nvim",
      config = function() require("plugin-configs.filetype") end,
    },

    -- ---------------------------------
    -- -加速颜色显示 & 文本直接显示颜色-
    -- ---------------------------------
    {
      "norcalli/nvim-colorizer.lua",
      config = function() require("colorizer").setup() end,
    },

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                  界面UI                                      │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    -- ----------
    -- -文件图标-
    -- ----------
    -- NOTE: 只存在于dependencies中的插件将进行lazy load
    -- {
    --   "kyazdani42/nvim-web-devicons",
    --   config = function() require("plugin-configs.nvim-web-devicons") end,
    -- },

    -- ----------
    -- -颜色主题-
    -- ----------
    {
      "navarasu/onedark.nvim",
      -- config = function() require("plugin-configs.onedark") end,
    },
    -- use({"RRethy/nvim-base16"})
    -- use({
    --   "tanvirtin/monokai.nvim",
    --   config = [[require("plugin-configs.monokai")]]
    -- })
    -- use({
    --  'marko-cerovac/material.nvim',
    --  config = function () require("plugin-configs.material") end
    -- })

    -- ------------------
    -- -侧边栏文件目录树-
    -- ------------------
    {
      'nvim-tree/nvim-tree.lua',
      dependencies = 'nvim-tree/nvim-web-devicons', -- optional, for file icons
      verson = 'nightly', -- optional, updated every week. (see issue #1193)
      config = function() require("plugin-configs.nvim-tree") end,
    },

    -- ------------
    -- -底部状态栏-
    -- ------------
    -- use({
    --     "feline-nvim/feline.nvim",
    --     config = function() require("plugin-configs.feline") end,
    -- })
    -- NOTE: feline有很多问题，这里将其更换为使用更多的lualine，基本问题都得到了解决
    {
      'nvim-lualine/lualine.nvim',
      dependencies = 'nvim-tree/nvim-web-devicons',
      config = function () require("plugin-configs.lualine") end
    },

    -- --------------
    -- -顶部buffer栏-
    -- --------------
    {
      "romgrk/barbar.nvim",
      dependencies = "nvim-tree/nvim-web-devicons",
      config = function() require("plugin-configs.barbar") end,
    },
    -- use {
    --   'akinsho/bufferline.nvim', tag = "v3.*",
    --   requires = 'nvim-tree/nvim-web-devicons',
    --   config = function() require("bufferline").setup() end
    -- }

    -- ----------------
    -- -好看的提示信息-
    -- ----------------
    -- NOTE: 只存在于dependencies中的插件将进行lazy load
    -- { "rcarriga/nvim-notify" },

    -- ---------------------
    -- -cmdline和notify美化-
    -- ---------------------
    {
      "folke/noice.nvim",
      config = function() require("plugin-configs.noice") end,
      dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
      }
    },

    -- --------
    -- -启动页-
    -- --------
    {
      'glepnir/dashboard-nvim',
      config = function() require("plugin-configs.dashboard") end
    },

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                  编辑增强                                    │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    -- --------------------------------------------------
    -- -Treesitter相关（语法解析工具，让编辑器理解代码）-
    -- --------------------------------------------------
    {
      "nvim-treesitter/nvim-treesitter",
      build = function()
        local installer = loadModule("nvim-treesitter.install", "plugin-configs")
        installer.prefer_git = false
        installer.compilers = {"gcc", "clang"}
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
      end,
      config = function() require("plugin-configs.nvim-treesitter") end,
    },
    -- treesitter的一个模块，其可以为嵌套的括号显示不同的颜色
    {
      "p00f/nvim-ts-rainbow",
      dependencies = "nvim-treesitter/nvim-treesitter",
    },

    -- ------
    -- -注释-
    -- ------
    -- use({ "JoosepAlviste/nvim-ts-context-commentstring" })
    -- use({
    --   "b3nj5m1n/kommentary",
    --   config = [[require("plugin-configs.kommentary")]],
    -- })
    -- use({
    --   "LudoPinelli/comment-box.nvim",
    --   config = [[require("plugin-configs.comment-box")]],
    -- })
    {
      'numToStr/Comment.nvim',
      config = function() require("plugin-configs.Comment") end,
    },

    -- --------------------
    -- -自动输入匹配的括号-
    -- --------------------
    {
      "windwp/nvim-autopairs",
      config = function() require("plugin-configs.nvim-autopairs") end,
    },

    -- ----------
    -- -缩进显示-
    -- ----------
    {
      "lukas-reineke/indent-blankline.nvim",
      config = function() require("plugin-configs.indent_blankline") end,
    },

    -- --------------
    -- -重复上次操作-
    -- --------------
    {"tpope/vim-repeat"},  -- leap的重复需要用到

    -- ----------
    -- -快速移动-
    -- ----------
    -- leap是sneak-like的快速移动插件，我用easymotion用惯了。
    -- use({
    --   "ggandor/leap.nvim",
    --   requires = "tpope/vim-repeat",
    --   config = function() require("leap").add_default_mappings(true) end,
    -- })
    -- NOTE: leap在visual mode下会是x键失效，这是我常用的一个键（用来删除），所以还是转向了
    -- easymotion-like的插件（hop）
    {
      'phaazon/hop.nvim',
      branch = 'v2', -- optional but strongly recommended
      config = function() require("plugin-configs.hop") end
    },

    -- ------------------
    -- -两侧字符快速修改-
    -- ------------------
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      config = function() require("nvim-surround").setup() end
    },

    -- ----------------
    -- -TODO及其他标识-
    -- ----------------
    {
      "folke/todo-comments.nvim",
      dependencies = "nvim-lua/plenary.nvim",
      config = function() require("plugin-configs.todo_comments") end
    },

    -- ----------
    -- -多行操作-
    -- ----------
    -- TODO: 和原始键位设置存在冲突，且其无法修改，暂时不用了
    -- use({'mg979/vim-visual-multi', branch = "master",
    -- config = function()
    --   -- 取消所有的默认键位映射，只保留一个
    --   vim.opt.VM_default_mappings=0
    -- end})

    -- ------------------
    -- -高亮光标所在对象-
    -- ------------------
    {"RRethy/vim-illuminate"},

    -- ------------------
    -- -自动删除行尾空格-
    -- ------------------
    {
      "cappyzawa/trim.nvim",
      config = function ()
        loadModule("trim").setup({
          disable = {},
          patterns = {},
          trim_trailing = true,
          trim_last_line = true,
          trim_first_line = true,
        })
      end
    },

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                 快捷键菜单                                   │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    {
      "folke/which-key.nvim",
      commit = "6885b669523ff4238de99a7c653d47b81b5506d",
      config = function() require("plugin-configs.which-key") end,
    },

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                                  文件查找                                    │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    -- ------------
    -- -文件查找器-
    -- ------------
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
      dependencies = { {'nvim-lua/plenary.nvim'} },
      config = function() require("plugin-configs.telescope") end,
    },

    -- --------------
    -- -加快搜索速度-
    -- --------------
    {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    -- ----------
    -- -路径搜索-
    -- ----------
    {"nvim-telescope/telescope-file-browser.nvim"},

    -- ------------------------------------
    -- -将vim.ui.select交由telescope来控制-
    -- ------------------------------------
    --
    {
      'nvim-telescope/telescope-ui-select.nvim' ,
      config = function() require("plugin-configs.ui_select") end
    },

    -- -------------
    -- -session管理-
    -- -------------
    -- NOTE: persistd.nvim和nvim-tree的配合不好
    -- use({
    --   "olimorris/persisted.nvim",
    --   --module = "persisted", -- For lazy loading
    --   config = function() require("plugin-configs.persisted") end
    --
    -- })
    {
      "Shatur/neovim-session-manager",
      config = function() require("plugin-configs.session-manager") end
    },

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                     LSP/CMP: 代码提示/ 补全配置/ UI增强                      │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    -- nvim自带lsp功能，即其可以作为language server的客户端。
    { "neovim/nvim-lspconfig" },                 -- lspconfig 用于配置nvim的lsp功能，lsp需要自己安装
    { "williamboman/mason.nvim" },               -- LSP/DAP 服务器安装管理工具，这样lsp可以有统一的界面进行安装和管理
    { "williamboman/mason-lspconfig.nvim" },     -- LSP/DAP 服务器安装管理工具，用来链接mason和lspconfig之间的gap，比如名称的区别

    { "hrsh7th/cmp-nvim-lsp" },                  -- 使cmp可以利用到lsp中的source
    { "hrsh7th/cmp-vsnip" },                     -- 使cmp可以利用到vsnip中的source
    { "hrsh7th/cmp-buffer" },                    -- { name = 'buffer' },
    { "hrsh7th/cmp-path" },                      -- { name = 'path' }
    { "hrsh7th/cmp-cmdline" },                   -- { name = 'cmdline' }
    { "hrsh7th/nvim-cmp" },                      -- 补全引擎，nvim虽然能够作为客户端和LSP通讯，但是其没有自动补全（可以手动补全）
    { "hrsh7th/vim-vsnip" },                     -- vim-vsnip 插件，提供snippets
    -- use({ "hrsh7th/cmp-nvim-lsp-signature-help" })   -- { name = 'nvim_lsp_signature_help' }
    -- use({ "hrsh7th/cmp-nvim-lua" })                  -- { name = 'nvim_lua' }
    -- use({ "jose-elias-alvarez/null-ls.nvim" })       -- 多语言代码检查工具, 功能类似 ESLint
    { "rafamadriz/friendly-snippets" },          -- 常见编程语言 snippets

    {
      "glepnir/lspsaga.nvim",
      event = 'BufRead',
      config = function() require('plugin-configs.lspsaga') end
    },                   -- UI 增强，将诊断、定义跳转等展示方式进行了增强

    -- ╭──────────────────────────────────────────────────────────────────────────────╮
    -- │                             整合其他工具                                     │
    -- ╰──────────────────────────────────────────────────────────────────────────────╯
    -- --------------
    -- -整合terminal-
    -- --------------
    {
      "akinsho/toggleterm.nvim",
      version = '*',
      config = function() require("plugin-configs.toggleterm") end
    },
    -- ---------
    -- -整合git-
    -- ---------
    {
      "lewis6991/gitsigns.nvim",
      config = function() require("plugin-configs.gitsigns") end
    },


  },
  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │                           lazy 插件管理器配置                                │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
  {
    root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
    defaults = {
      lazy = false, -- should plugins be lazy-loaded?
      version = nil,
      -- version = "*", -- enable this to try installing the latest stable versions of plugins
    },
    -- leave nil when passing the spec as the first argument to setup()
    spec = nil, ---@type LazySpec
    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
    concurrency = nil, ---@type number limit the maximum amount of concurrent tasks
    git = {
      -- defaults for the `Lazy log` command
      -- log = { "-10" }, -- show the last 10 commits
      log = { "--since=3 days ago" }, -- show commits from the last 3 days
      timeout = 120, -- kill processes that take more than 2 minutes
      url_format = "https://github.com/%s.git",
    },
    dev = {
      -- directory where you store your local plugin projects
      path = "~/projects",
      ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
      patterns = {}, -- For example {"folke"}
    },
    install = {
      -- install missing plugins on startup. This doesn't increase startup time.
      missing = true,
      -- try to load one of these colorschemes when starting an installation during startup
      colorscheme = { "habamax" },
    },
    ui = {
      -- a number <1 is a percentage., >1 is a fixed size
      size = { width = 0.8, height = 0.8 },
      wrap = true, -- wrap the lines in the ui
      -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
      border = "none",
      icons = {
        cmd = " ",
        config = "",
        event = "",
        ft = " ",
        init = " ",
        import = " ",
        keys = " ",
        lazy = "鈴 ",
        loaded = "●",
        not_loaded = "○",
        plugin = " ",
        runtime = " ",
        source = " ",
        start = "",
        task = "✔ ",
        list = {
          "●",
          "➜",
          "★",
          "‒",
        },
      },
      -- leave nil, to automatically select a browser depending on your OS.
      -- If you want to use a specific browser, you can define it here
      browser = nil, ---@type string?
      throttle = 20, -- how frequently should the ui process render events
      custom_keys = {
        -- you can define custom key maps here.
        -- To disable one of the defaults, set it to false

        -- open lazygit log
        -- ["<localleader>l"] = function(plugin)
        --   require("lazy.util").float_term({ "lazygit", "log" }, {
        --     cwd = plugin.dir,
        --   })
        -- end,

        -- open a terminal for the plugin dir
        -- ["<localleader>t"] = function(plugin)
        --   require("lazy.util").float_term(nil, {
        --     cwd = plugin.dir,
        --   })
        -- end,
      },
    },
    diff = {
      -- diff command <d> can be one of:
      -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
      --   so you can have a different command for diff <d>
      -- * git: will run git diff and open a buffer with filetype git
      -- * terminal_git: will open a pseudo terminal with git diff
      -- * diffview.nvim: will open Diffview to show the diff
      cmd = "git",
    },
    checker = {
      -- automatically check for plugin updates
      enabled = false,
      concurrency = nil, ---@type number? set to 1 to check for updates very slowly
      notify = true, -- get a notification when new updates are found
      frequency = 3600, -- check for updates every hour
    },
    change_detection = {
      -- automatically check for config file changes and reload the ui
      enabled = true,
      notify = true, -- get a notification when changes are found
    },
    performance = {
      cache = {
        enabled = true,
        path = vim.fn.stdpath("cache") .. "/lazy/cache",
        -- Once one of the following events triggers, caching will be disabled.
        -- To cache all modules, set this to `{}`, but that is not recommended.
        -- The default is to disable on:
        --  * VimEnter: not useful to cache anything else beyond startup
        --  * BufReadPre: this will be triggered early when opening a file from the command line directly
        disable_events = { "UIEnter", "BufReadPre" },
        ttl = 3600 * 24 * 5, -- keep unused modules for up to 5 days
      },
      reset_packpath = true, -- reset the package path to improve startup time
      rtp = {
        reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
        ---@type string[]
        paths = {}, -- add any custom paths here that you want to indluce in the rtp
        ---@type string[] list any plugins you want to disable here
        disabled_plugins = {
          -- "gzip",
          -- "matchit",
          -- "matchparen",
          -- "netrwPlugin",
          -- "tarPlugin",
          -- "tohtml",
          -- "tutor",
          -- "zipPlugin",
        },
      },
    },
    -- lazy can generate helptags from the headings in markdown readme files,
    -- so :help works even for plugins that don't have vim docs.
    -- when the readme opens with :help it will be correctly displayed as markdown
    readme = {
      root = vim.fn.stdpath("state") .. "/lazy/readme",
      files = { "README.md", "lua/**/README.md" },
      -- only generate markdown helptags for plugins that dont have docs
      skip_if_doc_exists = true,
    },
    state = vim.fn.stdpath("state") .. "/lazy/state.json", -- state info for checker and other things
  }
)

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
