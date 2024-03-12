local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- Enable spell checking
vim.opt.spell = true

-- Set the spell language to en_us
vim.opt.spelllang = "en_us"

vim.opt.termguicolors = true
