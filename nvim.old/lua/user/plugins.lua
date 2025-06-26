-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

packer = require 'packer'

return packer.startup(function()
  use 'wbthomason/packer.nvim'

  -- use {
  --   'goolord/alpha-nvim',
  --   requires = { 'nvim-tree/nvim-web-devicons' },
  --   config = function ()
  --     local alpha = require("alpha")
  --     local dashboard = require("alpha.themes.dashboard")
  --     dashboard.section.header.val = {
  --         "    ___   ____ ____    __    ____   ____",
  --         "____\\  \\_/_  //   /___.\\_)._/_  /_./_  /____",
  --         "\\    _  | '_/ \\___    |   | _/    | '_/    /",
  --         " \\   \\  |  \\   | /    |   | \\     |  \\    /",
  --         " /______|______|______|___|__\\____|_______\\",
  --         "+-diP----------------------------------aSL-+",
  --     }
  --     alpha.setup(dashboard.opts)
  --   end
  -- }

  -- Color themes
  use 'Mofiqul/dracula.nvim'
  use 'folke/tokyonight.nvim'
  use "rebelot/kanagawa.nvim"
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'sho-87/kanagawa-paper.nvim'
  use '0xstepit/flow.nvim'
  use 'olimorris/onedarkpro.nvim'
  use 'tiagovla/tokyodark.nvim'

  -- use 'editorconfig/editorconfig-vim'
  use 'junegunn/vim-easy-align' -- Align characters with ga
  use 'junegunn/vim-peekaboo'   -- Register preview
  use 'justinmk/vim-dirvish'    -- Nicer file navigator
  use 'machakann/vim-highlightedyank'
  use 'mbbill/undotree'
  use 'nelstrom/vim-visual-star-search'
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use 'tpope/vim-eunuch' -- Vim sugar for the UNIX shell commands e.g. Rename, Delete
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup()
    end
  })
  use 'tpope/vim-unimpaired' -- Complementary pairs of mappings with ][
  use 'easymotion/vim-easymotion'
  use 'folke/neodev.nvim'
  use {
    'mortepau/codicons.nvim',
    config = function()
      require('codicons')
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })


          require("which-key").add({
            { "hB", function() gs.blame_line { full = true } end, buffer = bufnr, desc = "Blame line full", remap = false },
            { "hD", function() gs.diffthis('~') end, buffer = bufnr, desc = "Diff this ~", remap = false },
            { "hR", gs.reset_buffer, buffer = bufnr, desc = "Reset buffer", remap = false },
            { "hS", gs.stage_buffer, buffer = bufnr, desc = "Stage buffer", remap = false },
            { "hb", gs.toggle_current_line_blame, buffer = bufnr, desc = "Toggle current line blame", remap = false },
            { "hd", gs.diffthis, buffer = bufnr, desc = "Diff this", remap = false },
            { "hp", gs.preview_hunk, buffer = bufnr, desc = "Preview hunk", remap = false },
            { "hr", gs.reset_hunk, buffer = bufnr, desc = "Reset hunk", remap = false },
            { "hs", gs.stage_hunk, buffer = bufnr, desc = "Stage hunk", remap = false },
            { "htd", gs.toggle_deleted, buffer = bufnr, desc = "Toggle deleted", remap = false },
            { "hu", gs.undo_stage_hunk, buffer = bufnr, desc = "Undo stage hunk", remap = false },
          })
          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end

      })
    end
  }
  use {
    "klen/nvim-config-local",
    config = function()
      require('config-local').setup()
    end
  }

  use {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  }

  -- Language Server Protocol
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind-nvim'

  use {
    'nvimtools/none-ls.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
  }
  use 'nvimtools/none-ls-extras.nvim'

  use {
    "pmizio/typescript-tools.nvim",
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  }

  use 'ray-x/lsp_signature.nvim'
  use 'simrat39/symbols-outline.nvim'
  
  use {
    'mason-org/mason.nvim',
    config = function()
      require('mason').setup()
    end
  }
  use {
    'mason-org/mason-lspconfig.nvim',
    config = function()
      require("mason-lspconfig").setup()
    end
  }

  -- Tree Sitter
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use "nvim-treesitter/playground"

  -- Telescope
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('telescope').setup()
      require('telescope').load_extension('fzf')
    end
  }

  -- Lualine Status line
  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        sections = {
          lualine_c = {
            'filename',
            {'aerial', exact = false},
          }
        },
        -- options = {
        --   -- theme = 'dracula-nvim'
        --   -- theme = 'tokyonight'
        --   theme = 'gruvbox_dark'
        -- }
      }
    end
  }

  -- CMP completions
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use "rafamadriz/friendly-snippets"
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rcarriga/cmp-dap'

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end
  }

  -- adds indentation guides to all lines (including empty lines)
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('ibl').setup()
    end
  }

  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end
  }

  -- matching punctuation characters
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }

  -- jk or jj to escape insert mode without delay
  use {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  }

  -- A pretty list for showing diagnostics, references etc.
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end
  }

  -- Color code nested punctuation pairs
  -- use 'p00f/nvim-ts-rainbow'
  use 'HiPhish/rainbow-delimiters.nvim'

  -- Debug adapter protocol
  use {
    "rcarriga/nvim-dap-ui",
    requires = {
	    "mfussenegger/nvim-dap",
	    "nvim-neotest/nvim-nio"},
    config = function()
      require("dapui").setup()
    end
  }
  -- use 'mfussenegger/nvim-dap'

  use({
    "grahambates/68kcounter-nvim",
    config = function()
      require("68kcounter").setup({
        -- path to 68kcounter node cli tool (default assumes global path)
        bin_path = "68kcounter"
      })
    end,
  })

  use({
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup({
        filter_kind = false
        -- filter_kind = {
        --   "Class",
        --   "Constructor",
        --   "Enum",
        --   "Function",
        --   "Interface",
        --   "Module",
        --   "Method",
        --   "Struct",
        -- },
      })
    end,
  })
end)
