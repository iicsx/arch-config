local M = {}

M.plugins = {
  -- Git integration
  "tpope/vim-fugitive",
  "iicsx/gint-nvim",

  -- Tree Sitter
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-context",
  "nvim-treesitter/playground",

  -- LSP
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "onsails/lspkind.nvim",
  "windwp/nvim-ts-autotag",

  -- File Management
  "theprimeagen/harpoon",
  "stevearc/oil.nvim",
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.4",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = 'make'
      },
    },
  },

  -- Undotree
  "mbbill/undotree",

  -- Themes
  "olivercederborg/poimandres.nvim",
  "Tsuzat/NeoSolarized.nvim",
  "Yazeed1s/oh-lucy.nvim",
  "sainnhe/sonokai",
  "folke/tokyonight.nvim",
  "ellisonleao/gruvbox.nvim",

  -- Visual
  "HiPhish/rainbow-delimiters.nvim",
  "echasnovski/mini.indentscope",
  "nvim-tree/nvim-web-devicons",
  "xiyaowong/transparent.nvim",
  "lewis6991/gitsigns.nvim",
  "romgrk/barbar.nvim",
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  "nvimdev/dashboard-nvim",
  "norcalli/nvim-colorizer.lua",

  -- Formatting
  "stevearc/conform.nvim",
  "m4xshen/autoclose.nvim",
  "alvan/vim-closetag",

  -- Markdown
  {
    "MeanderingProgrammer/markdown.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  -- Obsidian specifics
  "oflisback/obsidian-bridge.nvim",
  "coddingtonbear/obsidian-local-rest-api",
  "epwalsh/obsidian.nvim",

  -- MISC --
  "diepm/vim-rest-console",
  "chomosuke/typst-preview.nvim",
  "numToStr/Comment.nvim",
  "echasnovski/mini.animate",
  "nvim-mini/mini.ai",

  -- AI Integration
  -- "robitx/gp.nvim",
  -- 'github/copilot.vim',
}

return M
