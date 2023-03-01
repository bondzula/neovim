return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "windwp/nvim-ts-autotag" },
    },
    build = ":TSUpdate",
    event = "BufReadPost",
    opts = {
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      ensure_installed = require('util.lists').treesitter_parsers,
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-Space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
      autotag = {
        enable = true,
      },
    },
  },
}
