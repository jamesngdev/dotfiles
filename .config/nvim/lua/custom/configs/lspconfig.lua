local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "pyright", "dockerls", "eslint" }

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

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

local function find_tsconfig_file()
  local current_dir = vim.fn.expand "%:p:h" -- Get the current directory
  local root_dir = nil

  -- Find the root directory containing the .git folder
  while current_dir ~= "/" do
    local git_dir = current_dir .. "/.git"
    if vim.fn.isdirectory(git_dir) == 1 then
      root_dir = current_dir
      break
    end
    current_dir = vim.fn.fnamemodify(current_dir, ":h")
  end

  -- If root directory found, check for tsconfig files
  if root_dir then
    local tsconfig_files = {
      root_dir .. "/tsconfig.json",
      root_dir .. "/tsconfig.base.json",
    }
    for _, file_path in ipairs(tsconfig_files) do
      if vim.fn.filereadable(file_path) == 1 then
        return file_path
      end
    end
  end

  -- Return nil if no tsconfig file found
  return nil
end

lspconfig.tsserver.setup {
  root_dir = function(...)
    return require("lspconfig.util").root_pattern ".git"(...)
  end,
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  settings = {
    files = {
      path = find_tsconfig_file(),
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

-- -- TailwindCSS setup

local tailwind_on_attach = function(client, bufnr)
  -- Check if the tailwind config file exists in the current directory
  local tailwind_config_files = { "tailwind.config.js", "tailwind.config.ts", "tailwind.config.json" }
  local has_tailwind_config = false
  for _, file in ipairs(tailwind_config_files) do
    local full_path = vim.fn.expand "%:p:h" .. "/" .. file
    if vim.fn.filereadable(full_path) == 1 then
      has_tailwind_config = true
      break
    end
  end

  -- Load tailwind configuration only if the config file exists
  if has_tailwind_config then
    require("tailwindcss-colors").buf_attach(bufnr)
  end
end

lspconfig.tailwindcss.setup {
  -- other settings --
  on_attach = tailwind_on_attach,
}

-- Python setup
lspconfig.pyright.setup {}

-- Docker setup
lspconfig.dockerls.setup {}

-- HTML setup
lspconfig.html.setup {}

-- ESLINT  setup
lspconfig.eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = function(fname)
    return require("lspconfig").util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")(fname)
      or vim.loop.os_homedir()
  end,
}
