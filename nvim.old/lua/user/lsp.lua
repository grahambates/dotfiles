require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

-- Initialise icons for LSP completions
require('lspkind').init({
  mode = 'symbol_text',
})


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

vim.lsp.config("*", {
  capabilities = capabilities,
  on_attach = on_attach,
})

-- vim.lsp.set_log_level("info")
local lspconfig = require('lspconfig')

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

require("typescript-tools").setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    tsserver_file_preferences = {
      disableSuggestions = true,
    },
  },
}

-- local null_ls = require("null-ls")
-- null_ls.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   sources = {
--     null_ls.builtins.formatting.prettier,
--     -- null_ls.builtins.formatting.prettier_d_slim,
--     require("none-ls.diagnostics.eslint_d"),
--     require("none-ls.code_actions.eslint_d"),
--     -- require("none-ls.formatting.eslint_d"),
--     -- require("none-ls.diagnostics.eslint"),
--     -- require("none-ls.code_actions.eslint"),
--     -- require("none-ls.formatting.eslint"),
--   },
-- })
