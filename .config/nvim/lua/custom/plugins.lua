local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    config = function()
      require "custom.configs.conform"
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    event = { "InsertEnter" },
    cmd = { "Copilot" },
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-c>",
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "custom.configs.lint"
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("dashboard").setup {
        config = {
          header = {
            "",
            "     ██╗ █████╗ ███╗   ███╗███████╗███████╗    ██████╗ ███████╗██╗   ██╗",
            "     ██║██╔══██╗████╗ ████║██╔════╝██╔════╝    ██╔══██╗██╔════╝██║   ██║",
            "     ██║███████║██╔████╔██║█████╗  ███████╗    ██║  ██║█████╗  ██║   ██║",
            "██   ██║██╔══██║██║╚██╔╝██║██╔══╝  ╚════██║    ██║  ██║██╔══╝  ╚██╗ ██╔╝",
            "╚█████╔╝██║  ██║██║ ╚═╝ ██║███████╗███████║    ██████╔╝███████╗ ╚████╔╝ ",
            " ╚════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚══════╝    ╚═════╝ ╚══════╝  ╚═══╝  ",
            "",
          },
          shortcut = {
            { desc = "[  Github]", group = "DashboardShortCut" },
            { desc = "[  jamesngdev]", group = "DashboardShortCut" },
            { desc = "[  Fullstack Developer]", group = "DashboardShortCut" },
          },
        },
      }
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.formatter"
    end,
  },
  {
    "themaxmarchuk/tailwindcss-colors.nvim",
    event = "VeryLazy",
    config = function()
      require("tailwindcss-colors").setup()
    end,
  },
  { "wakatime/vim-wakatime", lazy = false },
  {
    "samodostal/image.nvim",
    event = "VeryLazy",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("image").setup {
        render = {
          min_padding = 5,
          show_label = true,
          show_image_dimensions = true,
          use_dither = true,
          foreground_color = true,
          background_color = true,
        },
        events = {
          update_on_nvim_resize = true,
        },
      }
    end,
  },
  {
    "m00qek/baleia.nvim",
    lazy = false,
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },
  {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    requires = { "nvim-lua/plenary.nvim" },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  -- {
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   config = true,
  -- },
  {
    "glepnir/template.nvim",
    cmd = { "Template", "TemProject" },
    config = function()
      require("template").setup {
        temp_dir = "~/.config/nvim/templates/",
      }
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      background_color = "#f2324d",
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    setup = function(_, opts)
      require("notify").setup(vim.tbl_extend("keep", {
        background_colour = "#0fffea",
      }, opts))
    end,
  },
}

return plugins
