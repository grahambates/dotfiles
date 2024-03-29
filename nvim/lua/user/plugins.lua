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

  -- Color themes
  use 'Mofiqul/dracula.nvim'
  use 'folke/tokyonight.nvim'
  use "rebelot/kanagawa.nvim"

  use 'editorconfig/editorconfig-vim'
  use 'junegunn/vim-easy-align' -- Align characters with ga
  use 'junegunn/vim-peekaboo'   -- Register preview
  use 'justinmk/vim-dirvish'    -- Nicer file navigator
  use 'machakann/vim-highlightedyank'
  use 'mbbill/undotree'
  use 'nelstrom/vim-visual-star-search'
  -- use 'tpope/vim-commentary'
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use 'tpope/vim-eunuch' -- Vim sugar for the UNIX shell commands e.g. Rename, Delete
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  -- use 'tpope/vim-surround'
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

          require("which-key").register({
            h = {
              s = { gs.stage_hunk, "Stage hunk", buffer = bufnr, noremap = true },
              r = { gs.reset_hunk, "Reset hunk", buffer = bufnr, noremap = true },
              S = { gs.stage_buffer, "Stage buffer", buffer = bufnr, noremap = true },
              u = { gs.undo_stage_hunk, "Undo stage hunk", buffer = bufnr, noremap = true },
              R = { gs.reset_buffer, "Reset buffer", buffer = bufnr, noremap = true },
              p = { gs.preview_hunk, "Preview hunk", buffer = bufnr, noremap = true },
              B = { function() gs.blame_line { full = true } end, "Blame line full", buffer = bufnr, noremap = true },
              b = { gs.toggle_current_line_blame, "Toggle current line blame", buffer = bufnr, noremap = true },
              d = { gs.diffthis, "Diff this", buffer = bufnr, noremap = true },
              D = { function() gs.diffthis('~') end, "Diff this ~", buffer = bufnr, noremap = true },
              td = { gs.toggle_deleted, "Toggle deleted", buffer = bufnr, noremap = true },
            },
          })

          --           -- Actions
          --           map('n', '<leader>hs', gs.stage_hunk)
          --           map('n', '<leader>hr', gs.reset_hunk)
          --           map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          --           map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          --           map('n', '<leader>hS', gs.stage_buffer)
          --           map('n', '<leader>hu', gs.undo_stage_hunk)
          --           map('n', '<leader>hR', gs.reset_buffer)
          --           map('n', '<leader>hp', gs.preview_hunk)
          --           map('n', '<leader>hb', function() gs.blame_line { full = true } end)
          --           map('n', '<leader>tb', gs.toggle_current_line_blame)
          --           map('n', '<leader>hd', gs.diffthis)
          --           map('n', '<leader>hD', function() gs.diffthis('~') end)
          --           map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end

      })
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

  use {
    "pmizio/typescript-tools.nvim",
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  }

  use 'ray-x/lsp_signature.nvim'
  use 'simrat39/symbols-outline.nvim'

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
        options = {
          -- theme = 'dracula-nvim'
          theme = 'tokyonight'
        }
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
  use 'p00f/nvim-ts-rainbow'

  -- Debug adapter protocol
  use {
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
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
end)
