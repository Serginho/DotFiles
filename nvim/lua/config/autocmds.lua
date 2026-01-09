-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Associate .hbs files with HTML syntax highlighting
vim.filetype.add({
  extension = {
    hbs = "html",
  },
})
