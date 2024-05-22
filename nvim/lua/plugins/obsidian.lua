return {
  {
    -- important: first close the plugins of obsidian than can modify the markdown file content, like linter, upate time on edit
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    keys = {
      { "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", desc = "quickly switch to (or open) a note in the vault" }
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter"
    },
    opts = {
      workspaces = {
        {
          name = "main",
          path = "~/OneDrive/obsidian/",
        },
      },

      -- Optional, alternatively you can customize the frontmatter data.
      ---@return table
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        -- if note.title then
        --   note:add_alias(note.title)
        -- end

        -- local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        local out = { updated = os.date("%Y-%m-%d %H:%M"), tags = note.tags }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        if out["created"] == nil then
          out["created"] = out["updated"]
        end

        return out
      end,

      -- callbacks = {
      --   -- Runs right before writing the buffer for a note.
      --   ---@param client obsidian.Client
      --   ---@param note obsidian.Note
      --   pre_write_note = function(client, note) end,
      -- }
    },

  }
}
