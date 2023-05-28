return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = false,
      integrations = {
        cmp = true,
        dashboard = false,
        gitsigns = true,
        leap = true,
        lsp_saga = true,
        lsp_trouble = true,
        markdown = true,
        mason = true,
        mini = false,
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
        neogit = false,
        neotree = false,
        noice = false,
        notify = false,
        octo = true,
        overseer = true,
        telescope = true,
        treesitter = true,
        which_key = false,
      },
    },
    config = function(opts)
      require("catppuccin").setup(opts)

      -- Set the theme
      vim.cmd.colorscheme("catppuccin")
    end
  },
}
