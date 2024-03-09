local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "pyright" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.cssls.setup {
  css = { validate = true, lint = {
    unknownAtRules = "ignore",
  } },
  scss = { validate = true, lint = {
    unknownAtRules = "ignore",
  } },
  less = { validate = true, lint = {
    unknownAtRules = "ignore",
  } },
}

--
-- lspconfig.pyright.setup { blabla}
--

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
}

---
--emmit config
---
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.emmet_ls.setup {
  -- on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "css",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "svelte",
    "pug",
    "typescriptreact",
    "vue",
  },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  },
}

-- TailwindCSS setup
local tailwind_on_attach = function(client, bufnr)
  -- other stuff --
  require("tailwindcss-colors").buf_attach(bufnr)
end

lspconfig.tailwindcss.setup {
  -- other settings --
  on_attach = tailwind_on_attach,
}

-- Python setup
lspconfig.pyright.setup {}
