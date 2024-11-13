require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

local lspconfig = require('lspconfig')

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  'intelephense',
  'gopls',
  'terraformls',
  'pyright',
  'clangd',
  'jsonls',
  'html',
  'cssls',
  'dockerls',
  -- 'kotlin',
  -- 'm68k',
}

-- vim.lsp.set_log_level("info")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Disable default formatting for languages handled by null-ls
  if client.name == "jsonls" or client.name == "html" or client.name == "cssls" or client.name == "typescript-tools" then
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
  end

  require "lsp_signature".on_attach()

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Format on save
  if client.name == "typescript-tools" or  client.name == "m68k" then
    vim.cmd[[
      augroup lsp_document_format
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
      augroup END
    ]]
  end

  require("which-key").add({
    { "<leader>'", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", buffer = 1, desc = "Workspace symbols", remap = false },
    { "<leader>fd", "<cmd>Telescope lsp_document_symbols<cr>", buffer = 1, desc = "Document symbols", remap = false },
    { "<leader>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", buffer = 1, desc = "Workspace symbols", remap = false },
    { "<leader>l", group = "Language" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", buffer = 1, desc = "Code action", remap = false },
    { "<leader>ld", "<cmd>Telescope lsp_document_symbols<cr>", buffer = 1, desc = "Document symbols", remap = false },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", buffer = 1, desc = "Format", remap = false },
    { "<leader>lo", "<cmd>SymbolsOutline<cr>", buffer = 1, desc = "Outline", remap = false },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", buffer = 1, desc = "Rename", remap = false },
    { "<leader>ls", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", buffer = 1, desc = "Workspace symbols", remap = false },
    { "<leader>lt", group = "Typescript" },
    { "<leader>lta", "<cmd>TSToolsAddMissingImports<cr>", buffer = 1, desc = "Add missing imports", remap = false },
    { "<leader>ltd", "<cmd>TSToolsGoToSourceDefinition<cr>", buffer = 1, desc = "Goes to source definition", remap = false },
    { "<leader>ltf", "<cmd>TSToolsFixAll<cr>", buffer = 1, desc = "Fix all fixable errors", remap = false },
    { "<leader>lto", "<cmd>TSToolsOrganizeImports<cr>", buffer = 1, desc = "Organize imports", remap = false },
    { "<leader>ltr", "<cmd>TSToolsRenameFile<cr>", buffer = 1, desc = "Rename file", remap = false },
    { "<leader>lts", "<cmd>TSToolsSortImports<cr>", buffer = 1, desc = "Sort imports", remap = false },
    { "<leader>ltu", "<cmd>TSToolsRemoveUnused<cr>", buffer = 1, desc = "Remove unused", remap = false },
    { "<leader>lw", group = "Workspace" },
    { "<leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", buffer = 1, desc = "Add folder", remap = false },
    { "<leader>lwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", buffer = 1, desc = "List folders", remap = false },
    { "<leader>lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", buffer = 1, desc = "Remove folder", remap = false },
  })

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>Trouble lsp_references<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end

-- Update capabilities for cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Initialise icons for LSP completions
require('lspkind').init({
  mode = 'symbol_text',
})

for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.m68k.setup {
  -- cmd = { "m68k-lsp-server", "--stdio" },
  cmd = { "/Users/batesgw1/projects/m68k-lsp/server/cli.js", "--stdio" },
  init_options = {
    -- trace = 'verbose',
    includePaths = { '../include', '..' },
    format = {
      align = {
        mnemonic = 16,
        operands = 24,
        comment = 40,
      }
    },
    vasm = {
      args = {"-nowarn=62"}
    }
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        disable = {
          'lowercase-global'
        },
        globals = {
          'vim',
          'use',
          'require',
          -- TIC-80
          'btn',
          'btnp',
          'circ',
          'circb',
          'clip',
          'cls',
          'elli',
          'ellib',
          'exit',
          'fget',
          'font',
          'fset',
          'key',
          'keyp',
          'line',
          'map',
          'memcpy',
          'memset',
          'mget',
          'mouse',
          'mset',
          'music',
          'peek',
          'peek1',
          'peek2',
          'peek4',
          'pix',
          'pmem',
          'poke',
          'poke1',
          'poke2',
          'poke4',
          'print',
          'rect',
          'rectb',
          'reset',
          'sfx',
          'spr',
          'sync',
          'time',
          'trace',
          'tri',
          'trib',
          'ttri',
          'vbank'
        },
      },
      workspace = {
        checkThirdParty = false,
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require("typescript-tools").setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    tsserver_file_preferences = {
      disableSuggestions = true,
    },
  },
}

local null_ls = require("null-ls")
null_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  sources = {
    -- null_ls.builtins.formatting.prettierd,
    require("none-ls.diagnostics.eslint_d"),
    require("none-ls.code_actions.eslint_d"),
    require("none-ls.formatting.eslint_d"),
  },
})

lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})
