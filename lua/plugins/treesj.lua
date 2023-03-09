-- Split / Join but using treesitter
return {
  "Wansmer/treesj",
  cmd = {
    "TSJSplit",
    "TSJJoin",
  },
  keys = {
    { "gJ", "<cmd>TSJJoin<cr>", desc = "Join using treesitter" },
    { "gS", "<cmd>TSJSplit<cr>", desc = "Split using treesitter" },
  },
  opts = {
    use_default_keymaps = false,
    check_syntax_error = true,
    max_join_length = 120,
    -- hold|start|end:
    cursor_behavior = 'hold',
    dot_repeat = true,
  }
}
