return {
  "github/copilot.vim",
  config = function()
    vim.keymap.set("i", "<C-e>", [[copilot#Accept("\<CR>")]], {
      silent = true,
      expr = true,
      script = true,
      replace_keycodes = false,
    })
  end,
}