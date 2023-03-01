-- Tmux integration
return {
  {
    "numToStr/Navigator.nvim",
    keys = {
      { "<C-h>", "<cmd>NavigatorLeft<cr>" },
      { "<C-l>", "<cmd>NavigatorRight<cr>" },
      { "<C-k>", "<cmd>NavigatorUp<cr>" },
      { "<C-j>", "<cmd>NavigatorDown<cr>" },
    },
    opts = {},
  },
}
