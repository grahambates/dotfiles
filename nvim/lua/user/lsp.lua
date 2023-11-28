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
  -- 'm68k',
}

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

  require("which-key").register({
    ["'"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace symbols", buffer = bufnr, noremap = true },
    f = {
      d = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols", buffer = bufnr, noremap = true },
      s = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace symbols", buffer = bufnr, noremap = true },
    },
    l = {
      name = "Language",
      f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format", buffer = bufnr, noremap = true },
      d = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols", buffer = bufnr, noremap = true },
      s = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace symbols", buffer = bufnr, noremap = true },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename", buffer = bufnr, noremap = true },
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action", buffer = bufnr, noremap = true },
      o = { "<cmd>SymbolsOutline<cr>", "Outline", buffer = bufnr, noremap = true },
      w = {
        name = "Workspace",
        a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "Add folder", buffer = bufnr, noremap = true },
        r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove folder", buffer = bufnr, noremap = true },
        l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", "List folders", buffer = bufnr, noremap = true },
      },
      t = {
        name = "Typescript",
        r = { "<cmd>TSToolsRenameFile<cr>", "Rename file", buffer = bufnr, noremap = true },
        o = { "<cmd>TSToolsOrganizeImports<cr>", "Organize imports", buffer = bufnr, noremap = true },
        s = { "<cmd>TSToolsSortImports<cr>", "Sort imports", buffer = bufnr, noremap = true },
        u = { "<cmd>TSToolsRemoveUnused<cr>", "Remove unused", buffer = bufnr, noremap = true },
        a = { "<cmd>TSToolsAddMissingImports<cr>", "Add missing imports", buffer = bufnr, noremap = true },
        f = { "<cmd>TSToolsFixAll<cr>", "Fix all fixable errors", buffer = bufnr, noremap = true },
        d = { "<cmd>TSToolsGoToSourceDefinition<cr>", "Goes to source definition", buffer = bufnr, noremap = true },
      },
    },
  }, { prefix = "<leader>" })

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
}

local null_ls = require("null-ls")
null_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.eslint_d,
    -- null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.eslint_d,
  },
})
