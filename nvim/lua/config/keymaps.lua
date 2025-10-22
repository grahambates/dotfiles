-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- map("n", "H", "^", opts)

map("n", "<leader>m", "<cmd>make<cr>", { desc = "Make" })
map("n", "<leader>r", "<cmd>write<cr><cmd>make run<cr>", { desc = "Make run" })
map("n", "<leader>p", "<cmd>put<cr>", { desc = "Put" })

map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
