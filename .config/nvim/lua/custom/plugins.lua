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
            "     Welcome to Neovim  ",
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
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "glepnir/template.nvim",
    cmd = { "Template", "TemProject" },
    config = function()
      require("template").setup {
        temp_dir = "~/.config/nvim/templates/",
      }
    end,
  },
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "rcarriga/nvim-notify",
  --   },
  --   opts = function()
  --     return require "custom.configs.noice"
  --   end,
  --   keys = function()
  --     return require "custom.configs.noice_keymap"
  --   end,
  -- },
  -- -- {
  --   "andweeb/presence.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("presence"):setup {
  --       auto_update = true,
  --       -- neovim_image_text = "VSCode",
  --       main_image = "neovim",
  --     }
  --   end,
  -- },
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      local t = {}
      t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "350", "sine", [['cursorline']] } }
      t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "350", "sine", [['cursorline']] } }

      require("neoscroll").setup {
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        mappings = t,
      }

      require("neoscroll.config").set_mappings(t)
    end,
  },
  -- {
  --   "diepm/vim-rest-console",
  --   event = "VeryLazy",
  --   config = function()
  --     vim.g.rest_console_type = "json"
  --     -- Turn off the default key binding
  --     vim.g.vrc_set_default_mapping = 0
  --
  --     -- Set the default response content type to JSON
  --     vim.g.vrc_response_default_content_type_content_type = "application/json"
  --
  --     -- - Set the output buffer name
  --     vim.g.vrc_output_buffer_name = "_OUTPUT.json"
  --
  --     vim.g.vrc_auto_format_response_patterns = {
  --       json = "python -m json.tool",
  --     }
  --
  --     vim.g.vrc_curl_opts = {
  --       ["-sS"] = "",
  --     }
  --   end,
  -- },
}

return plugins
