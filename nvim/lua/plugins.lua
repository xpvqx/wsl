require("lazy").setup({
  -- lsp
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- autocompletion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",

  -- gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines, and errors
        contrast = "hard", -- hard / soft / ''
        palette_overrides = {}, -- custom color overrides
        overrides = {}, -- custom highlights
        dim_inactive = false,
        transparent_mode = true,
      })

      vim.cmd("colorscheme gruvbox")
    end,
  },

  -- treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- nvim tree
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",

  -- nvim autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter", -- load the plugin when you enter insert mode
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- comment.nvim plugin
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    }
  },
})

-- completion setup
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
})

-- nvim-tree setup
require("nvim-tree").setup({
  open_on_tab = true,          -- open tree when a new tab is opened
  view = {
    width = 30,                -- width of the file tree
    side = "left",             -- position of the tree (left or right)
  },
  renderer = {
    highlight_opened_files = "name",  -- highlight opened files
  },
  actions = {
      open_file = {
          window_picker = {
              enable = false,
          },
      },
  },
})


-- nvim-treesitter setup
require("nvim-treesitter.configs").setup({
  ensure_installed = { "python", "lua", "json", "bash", "markdown" },
  highlight = {
    enable = true,
  },
})
