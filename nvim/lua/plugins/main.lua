return {
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

            -- ----------
            -- -智能缩进-
            -- ----------
            {
              'nmac427/guess-indent.nvim',
              config = function() require('guess-indent').setup {} end,
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
                  -- -整合tmux-
                  -- ---------
                  {
                    "aserowy/tmux.nvim",
                    config = function() require("plugin-configs.tmux") end
                  },




}
