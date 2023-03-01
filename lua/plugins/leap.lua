-- Nice navigation
return {
  {
    "ggandor/leap.nvim",
    dependencies = {
      { "tpope/vim-repeat" },
    },
    keys = {
      { "s" }, { "S" }
    },
    config = function()
      require('leap').add_default_mappings()
    end
  },

  -- Improve line jumps
  {
    "ggandor/flit.nvim",
    keys = {
      { "f" }, { "F" }, { "t" }, { "T" }
    },
    opts = {
      keys = { f = 'f', F = 'F', t = 't', T = 'T' },
      -- A string like "nv", "nvo", "o", etc.
      labeled_modes = "v",
      multiline = false,
    },
  },

  -- Get all fency doing things without even moving
  {
    "ggandor/leap-spooky.nvim",
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
