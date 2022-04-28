local lspconfig = require('lspconfig')
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Disable default formatting for tssever
  if client.name == "tsserver" then
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
        autocmd BufWritePre  <buffer> lua vim.lsp.buf.formatting()
      augroup END
    ]]
  end

  require("which-key").register({
    l = {
      name = "Language",
      w = {
        name = "Workspace",
        a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "Add folder", buffer = bufnr, noremap = true },
        r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove folder", buffer = bufnr, noremap = true },
        l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", "List folders", buffer = bufnr, noremap = true },
      },
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format", buffer = bufnr, noremap = true },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols", buffer = bufnr, noremap = true },
      S = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace symbols", buffer = bufnr, noremap = true },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename", buffer = bufnr, noremap = true },
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action", buffer = bufnr, noremap = true },
      -- gr = { "<cmd>Telescope lsp_references<cr>", "Find references (Telescope)", buffer = bufnr, noremap = true },
      -- gR = { "<cmd>Trouble lsp_references<cr>", "Find references (Trouble)", buffer = bufnr, noremap = true },
    },
  })

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
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

-- require("lspconfig.configs")["m68k"] = {
--   default_config = {
--     cmd = {'m68k-lsp-server', '--stdio'},
--     filetypes = { "asm68k" },
--     root_dir = lspconfig.util.root_pattern("Makefile", ".git"),
--     init_options = {
--       format = {
--         align = {
--           mnemonic = 20,
--           operands = 30,
--           comment = 45,
--           indentStyle = "space"
--         },
--         case = {
--           instruction = "lower",
--           directive = "lower",
--           control = "upper",
--           register = "lower",
--           sectionType = "lower",
--         },
--         quotes = "double"
--       }
--     }
--   },
-- }

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
  'm68k',
}

for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

require("typescript").setup({
  disable_formatting = true, 
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
      preferences = {
        disableSuggestions = true
      }
    }
  },
})

-- Stand-alone linters / formatters
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.prettierd
  },
  on_attach = on_attach
})
