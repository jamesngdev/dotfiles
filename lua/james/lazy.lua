local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "james.plugins" }, { import = "james.plugins.lsp" } }, {
  spec = { import =  "james.plugins" },
  dev = {
    path = "~/.config/nvim",
    patterns = { "azemetre" },
  },
  checker = {
    enabled = true,
    notify = false,
    frequency = 900,
  },
  change_detection = {
    notify = false,
    enabled = true,
  },
  ui = {
    icons = {
      plugin = "",
    },
  },
})

