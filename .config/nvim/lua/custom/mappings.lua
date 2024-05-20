---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["gb"] = { "<C-o>", "Go back to previous open file/buffer" },
    ["<leader>rn"] = {
      "<cmd>lua vim.lsp.buf.rename()<CR>",
    },
    ["<leader>s"] = {
      "<cmd>:w<CR>",
    },
    ["<leader>g"] = {
      "<cmd>:LazyGit<CR>",
    },
    ["<C-z>"] = {
      "<cmd>:w<CR>",
    },
    ["<C-e>"] = {
      "<cmd>:TroubleToggle<CR>",
    },
    ["<C-w>"] = {
      "<cmd>:NvimTreeFindFile<CR>",
    },
    ["<leader>sr"] = {
      "<cmd>:call VrcQuery()<CR>",
    },
    ["<leader>r"] = {
      "<cmd>:EslintFixAll<CR>",
    },
  },
  v = {
    [">"] = { ">gv", "indent" },

    ["<leader>fw"] = {
      "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>",
    },
    ["<leader>q"] = {
      "<cmd>lua vim.lsp.buf.code_action()<CR>",
      { noremap = true, silent = true },
    },
  },
}

-- What the fuck this man --

return M
