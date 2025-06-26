return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "m68k",
      })
    end,
  },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "m68k-lsp-server",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- m68k will be automatically installed with mason and loaded with lspconfig
        m68k = {},
      },
    },
  },

  { "HiPhish/rainbow-delimiters.nvim" },

  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },

  { "mbbill/undotree" },

  {
    "stevearc/aerial.nvim",
    opts = {
      filter_kind = false,
    },
  },

  {
    "Saghen/blink.cmp",
    opts = function(_, opts)
      local has_words_before = function()
        local col = vim.api.nvim_win_get_cursor(0)[2]
        if col == 0 then
          return false
        end
        local line = vim.api.nvim_get_current_line()
        return line:sub(col, col):match("%s") == nil
      end

      opts.keymap = vim.tbl_extend("force", opts.keymap, {
        preset = "enter",

        -- If completion hasn't been triggered yet, insert the first suggestion; if it has, cycle to the next suggestion.
        ["<Tab>"] = {
          function(cmp)
            if has_words_before() then
              return cmp.insert_next()
            end
          end,
          "fallback",
        },
        -- Navigate to the previous suggestion or cancel completion if currently on the first one.
        ["<S-Tab>"] = { "insert_prev" },
      })
      opts.completion = vim.tbl_extend("force", opts.completion, {
        auto_brackets = { enabled = false },
        -- menu = { enabled = false },
        list = { selection = { preselect = false }, cycle = { from_top = false } },
        accept = { auto_brackets = { enabled = false } },
      })
    end,
  },

  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = function()
      require("claude-code").setup()
    end,
  },
}
