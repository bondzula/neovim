return {
  -- catppuccin
  -- NOTE: When making changes on this file, run `CatppuccinCompile` to compile all those options
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      integrations = {
        cmp = true,
        dashboard = true,
        gitsigns = true,
        leap = true,
        lsp_saga = true,
        lsp_trouble = true,
        markdown = true,
        mason = true,
        mini = false,
        neogit = false,
        neotree = false,
        noice = false,
        notify = false,
        overseer = true,
        telescope = true,
        treesitter = true,
        which_key = false,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
    end
  },
}
