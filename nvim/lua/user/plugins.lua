-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- Color themes
  use 'Mofiqul/dracula.nvim'
  use 'folke/tokyonight.nvim'

  use 'editorconfig/editorconfig-vim'
  use 'junegunn/vim-easy-align' -- Align characters with ga
  use 'junegunn/vim-peekaboo' -- Register preview
  use 'justinmk/vim-dirvish' -- Nicer file navigator
  use 'machakann/vim-highlightedyank'
  use 'mbbill/undotree'
  use 'nelstrom/vim-visual-star-search'
  use 'tpope/vim-commentary'
  use 'tpope/vim-eunuch' -- Vim sugar for the UNIX shell commands e.g. Rename, Delete
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired' -- Complementary pairs of mappings with ][
  use 'easymotion/vim-easymotion'

  -- Language Server Protocol
  use {'grahambates/nvim-lspconfig', branch = "add_m68k_config"}
  use 'onsails/lspkind-nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'jose-elias-alvarez/typescript.nvim'
  use 'ray-x/lsp_signature.nvim'

  -- Tree Sitter
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use "nvim-treesitter/playground"

  -- Telescope
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
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
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'

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
      require('indent_blankline').setup()
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
  use 'mfussenegger/nvim-dap'
end)
