return {
  -- Batter split / join functionality
  -- TODO: use new treesitter based join functionality
  {
    "AndrewRadev/splitjoin.vim",
    keys = { { "gJ" }, { "gS" } },
    event = "BufReadPost",
  },
}
