-- Awesome file manager
return {
  {
    "lmburns/lf.nvim",
    dependencies = {
      { "akinsho/toggleterm.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    keys = {
      { "<leader>fl", "<cmd>Lf<cr>", desc = "LF File Manager" },
    },
    opts = {
      default_cmd = "lf", -- default `lf` command
      default_action = "edit", -- default action when `Lf` opens a file
      default_actions = { -- default action keybindings
        ["<C-t>"] = "tabedit",
        ["<C-x>"] = "split",
        ["<C-v>"] = "vsplit",
        ["<C-o>"] = "tab drop",
      },

      winblend = 0, -- psuedotransparency level
      highlights = { NormalFloat = { guibg = "NONE" } },
      border = "curved", -- border kind: single double shadow curved
      height = 0.80, -- height of the *floating* window
      width = 0.85, -- width of the *floating* window
      escape_quit = true, -- map escape to the quit command (so it doesn't go into a meta normal mode)
      focus_on_open = false, -- focus the current file when opening Lf (experimental)
    },
  },
}
