-- Improved LSP UI / UX
return {
  {
    "glepnir/lspsaga.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      symbol_in_winbar = {
        enable = false,
      },
      lightbulb = {
        enable = false,
      },
      ui = {
        title = true,
        border = "rounded",
      },
    },
  },
}
