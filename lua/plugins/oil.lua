return {
  {
    "stevearc/oil.nvim",
    keys = {
      { "<leader>fL", "<cmd>lua require('oil').open()<cr>", desc = "File Browser" },
      { "<leader>fl", "<cmd>lua require('oil').toggle_float()<cr>", desc = "File Browser (Floating)" },
    },
    opts = {
      keymaps = {
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-p>"] = "actions.preview",
        ["q"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
      },
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width = vim.fn.round(vim.o.columns * 0.8),
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 10,
        },
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
