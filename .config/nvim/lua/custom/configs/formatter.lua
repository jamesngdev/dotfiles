local M = {
  filetype = {
    javascript = {
      require("formatter.filetypes.javascript").prettier,
    },
    typescript = {
      require("formatter.filetypes.typescript").prettier,
    },
    javascriptreact = {
      require("formatter.filetypes.javascriptreact").prettier,
    },
    typescriptreact = {
      require("formatter.filetypes.typescriptreact").prettier,
    },
    css = {
      require("formatter.filetypes.css").prettier,
    },
    scss = {
      require("formatter.filetypes.css").prettier,
    },
    json = {
      require("formatter.filetypes.json").prettier,
    },
    graphql = {
      require("formatter.filetypes.graphql").prettier,
    },

    html = {
      require("formatter.filetypes.html").prettier,
    },

    lua = {
      require("formatter.filetypes.lua").stylua,
    },

    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace,
    },
  },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  command = "FormatWriteLock",
})

return M
