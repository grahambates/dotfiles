local lspconfig = require('lspconfig')

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  -- 'tsserver',
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
  if client.name == "jsonls" or client.name == "html" or client.name == "cssls" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  require "lsp_signature".on_attach()

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Format on save
  if client.resolved_capabilities.document_formatting then
    vim.cmd[[
      augroup lsp_document_format
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
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
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format", buffer = bufnr, noremap = true },
      d = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols", buffer = bufnr, noremap = true },
      s = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace symbols", buffer = bufnr, noremap = true },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename", buffer = bufnr, noremap = true },
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action", buffer = bufnr, noremap = true },
      w = {
        name = "Workspace",
        a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "Add folder", buffer = bufnr, noremap = true },
        r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove folder", buffer = bufnr, noremap = true },
        l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", "List folders", buffer = bufnr, noremap = true },
      },
      t = {
        name = "Typescript",
        r = { "<cmd>TypescriptRenameFile<cr>", "Rename file", buffer = bufnr, noremap = true },
        o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize imports", buffer = bufnr, noremap = true },
        u = { "<cmd>TypescriptRemoveUnused<cr>", "Remove unused", buffer = bufnr, noremap = true },
        a = { "<cmd>TypescriptAddMissingImports<cr>", "Add missing imports", buffer = bufnr, noremap = true },
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
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

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
  cmd = {'node', '--inspect', '/Users/batesgw1/m68k-lsp/server/cli.js', '--stdio'},
  -- trace = 'verbose',
  -- init_options = {
  --   trace = 'verbose',
  -- },
  on_attach = on_attach,
  capabilities = capabilities,
}
-- vim.lsp.set_log_level("trace")

-- Stand-alone linters / formatters
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    -- null_ls.builtins.diagnostics.eslint_d,
    -- null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.formatting.prettierd
  },
  on_attach = on_attach
})

require('typescript').setup({
  disable_formatting = true,
  server = {
    on_attach = on_attach
  }
})
