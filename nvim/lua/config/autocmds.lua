-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.filetype.add({
  extension = {
    asm = "asm68k",
    s = "asm68k",
  },
})

vim.cmd([[
  augroup asm68k
  autocmd!
  autocmd FileType asm68k setlocal commentstring=;\ %s
  augroup end
]])

if vim.g.vscode then
  local vscode = require("vscode")
  local group = vim.api.nvim_create_augroup("M68kFormatOnInsertLeave", { clear = true })

  vim.api.nvim_create_autocmd("InsertEnter", {
    group = group,
    pattern = { "*.s", "*.S", "*.asm", "*.ASM", "*.i" },
    callback = function(event)
      vim.b[event.buf].m68k_insert_tick = vim.api.nvim_buf_get_changedtick(event.buf)
    end,
  })

  vim.api.nvim_create_autocmd("InsertLeave", {
    group = group,
    pattern = { "*.s", "*.S", "*.asm", "*.ASM", "*.i" },
    callback = function(event)
      local before = vim.b[event.buf].m68k_insert_tick
      if before == nil or before == vim.api.nvim_buf_get_changedtick(event.buf) then
        return
      end

      local line = vim.fn.line(".") - 1
      vscode.action("editor.action.formatSelection", { range = { line, line } })
    end,
  })
end
