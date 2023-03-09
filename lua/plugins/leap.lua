-- Nice navigation
return {
  {
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
    },
    config = function()
      require('leap').add_default_mappings()
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end
  },

  -- Improve line jumps
  {
    "ggandor/flit.nvim",
    keys = {
      { "f", mode = { "n", "v" }, desc = "Jump to character forward" },
      { "F", mode = { "n", "v" }, desc = "Jump to character backward" },
      { "t", mode = { "n", "v" }, desc = "Jump til character forward" },
      { "T", mode = { "n", "v" }, desc = "Jump til character backward" },
    },
    opts = {
      keys = {
        f = 'f',
        F = 'F',
        t = 't',
        T = 'T',
      },
      labeled_modes = "v",
      multiline = false,
    },
  },

  -- Get all fency doing things without even moving
  {
    "ggandor/leap-spooky.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      affixes = {
        remote   = { window = 'r', cross_window = 'R' },
        magnetic = { window = 'm', cross_window = 'M' },
      },
      -- If this option is set to true, the yanked text will automatically be pasted
      -- at the cursor position if the unnamed register is in use.
      paste_on_remote_yank = false,
    },
  },
}
