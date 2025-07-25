-- TODO break up into files

return {
  --- *** VISUAL FEATURES *** ---
  {
    dir = "/home/main/programming/projects/salmon.nvim",
    opts = {},
    lazy = false,
    priority = 1337,
  },
  -- HIGHLIGHTING
  { "chrisbra/Colorizer" },
  -- icons
  { "nvim-tree/nvim-web-devicons" },
  {
    "rachartier/tiny-devicons-auto-colors.nvim",
    event = "VeryLazy",
    opts = {
      colors = {
        "#4F3BA3",
        "#812687",
        "#A23249",
        "#AA5400",
        "#897D00",
        "#007E2D",
        "#008274",
        "#008274",
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  --- *** USABILITY ENHANCEMENTS *** ---
  -- GENERAL UTILITIES
  {
    "folke/snacks.nvim",
    opts = {
      input = {
        enabled = true,
        win = {
          relative = "cursor",
          anchor = "NW",
          row = 1,
        },
      },
    },
  },
  { "m4xshen/autoclose.nvim" },
  { "numToStr/Comment.nvim" },
  { "kshenoy/vim-signature" },
  { "kylechui/nvim-surround" },
  { "nmac427/guess-indent.nvim", opts = {} },
  {
    "kevinhwang91/nvim-bqf",
    opts = { preview = { auto_preview = true, should_preview_cb = function() return true end } },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { highlight = { "IndentGuide" } },
      scope = { enabled = false },
    },
  },

  -- FILE NAVIGATION
  -- spectre
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = require("plugins.opts.telescope"),
  },
  { "nvim-telescope/telescope-ui-select.nvim", opts = {} },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      renderer = { group_empty = true },
      filters = { dotfiles = true },
      view = { width = 30 },
    },
  },
  -- structure
  {
    "stevearc/aerial.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  -- jumping around
  {
    "kwkarlwang/bufjump.nvim",
    opts = {
      -- forward_key = "<F13>",
      -- backward_key = "<F14>",
    },
  },

  -- SESSIONS AND SIMILAR
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      suppressed_dirs = { "~/", "~/programming", "~/programming/projects", "~/trash", "/" },
    },
  },
  {
    "okuuva/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      enabled = true,
      trigger_events = {
        defer_save = { "InsertLeave", "TextChanged" },
        immediate_save = { "BufLeave", "FocusLost" },
      },
      condition = function(buf)
        local content = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, true), "")
        return content:match("^%s*$") == nil
      end,
    },
  },

  -- DEBUGGING and testing
  {
    "Weissle/persistent-breakpoints.nvim",
    opts = { load_breakpoints_events = "BufReadPost" },
    lazy = false,
  },
  { "mfussenegger/nvim-dap" },
  { "jay-babu/mason-nvim-dap.nvim" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function() require("plugins.opts.dapui")() end,
  },
  { "williamboman/nvim-dap-virtual-text" },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "rcasia/neotest-java",
      "mrcjkb/rustaceanvim", -- provides rustaceanvim.neotest
    },
    config = function()
      require("neotest").setup({
        summary = {
          mappings = {
            watch = "<leader>w",
          },
        },
      })
    end,
  },

  -- INSPECTION
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      win = {
        position = "right", -- position of the trouble window
        size = { -- height of the trouble window
          width = 80, -- width of the trouble window
        },
      },
    },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  --- ** SEMANTIC FEATURES ** ---
  -- LSP
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  { "neovim/nvim-lspconfig" },
  -- FORMATTING + LINTING
  { "stevearc/conform.nvim", opts = {} },

  -- TREESITTER
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = { additional_vim_regex_highlighting = false },
    build = ":TSUpdate",
  },

  -- COMPLETIONS
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-cmdline", dependencies = "hrsh7th/nvim-cmp", event = "CmdlineEnter" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function() require("plugins.opts.cmp")() end,
  },

  -- AI
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
    config = function() require("copilot").setup({}) end,
    event = "InsertEnter",
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function() require("copilot_cmp").setup() end,
    dependencies = { "zbirenbaum/copilot.lua" },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {},
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- your existing Copilot backend
      { "nvim-lua/plenary.nvim" }, -- required utility lib
    },
    build = "make tiktoken", -- optional, Mac/Linux: native token counter
  },

  -- GIT
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      attach_to_untracked = true,
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "~" },
        changedelete = { text = "~" },
        untracked = { text = " " },
      },
      signs_staged = {
        add = { text = ">" },
        change = { text = ">" },
        delete = { text = ">" },
        topdelete = { text = ">" },
        changedelete = { text = ">" },
        untracked = { text = ">" },
      },
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,
  },
  {
    "FabijanZulj/blame.nvim",
    opts = {
      date_format = "%Y-%m-%d",
      -- TODO export from salmon?
      colors = {
        "#4F3BA3",
        "#812687",
        "#A23249",
        "#AA5400",
        "#897D00",
        "#007E2D",
        "#008274",
        "#006893",
      },
    },
  },

  --- *** LANGUAGE SPECIFIC *** ---
  -- python
  { "mfussenegger/nvim-dap-python" },
  { "nvim-neotest/neotest-python", dependencies = { "nvim-neotest/neotest" } },
  -- java
  { "nvim-java/nvim-java" },
  {
    "rcasia/neotest-java",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "mfussenegger/nvim-dap", -- for the debugger
      "rcarriga/nvim-dap-ui", -- recommended
      "theHamsta/nvim-dap-virtual-text", -- recommended
    },
  },
  -- lean
  {
    "Julian/lean.nvim",
    event = { "BufReadPre *.lean", "BufNewFile *.lean" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    opts = { mappings = true },
  },
  -- rust
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust", "rs" },
    init = function()
      vim.g.rustaceanvim = {
        tools = {
          hover_actions = { auto_focus = true },
        },
        server = {
          -- everything under `default_settings` is passed to rust-analyzer verbatim
          default_settings = {
            ["rust-analyzer"] = {
              check = { command = "clippy" }, -- run clippy on save
              cargo = { allFeatures = true },
            },
          },
        },
      }
    end,
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
      "jay-babu/mason-nvim-dap.nvim",
    },
  },
  {
    "nwiizo/cargo.nvim",
    build = "cargo build --release",
    config = function()
      require("cargo").setup({
        float_window = true,
        window_width = 0.8,
        window_height = 0.8,
        border = "rounded",
        auto_close = true,
        close_timeout = 5000,
      })
    end,
    ft = { "rust" },
    cmd = {
      "CargoBench",
      "CargoBuild",
      "CargoClean",
      "CargoDoc",
      "CargoNew",
      "CargoRun",
      "CargoRunTerm",
      "CargoTest",
      "CargoUpdate",
      "CargoCheck",
      "CargoClippy",
      "CargoAdd",
      "CargoRemove",
      "CargoFmt",
      "CargoFix",
    },
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = true,
  },
  -- markdown
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
  },
}
