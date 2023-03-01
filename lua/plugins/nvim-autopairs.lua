return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      -- Setup auto-pairs to work with cmp if its present
      local cmp_loaded, cmp = pcall(require, "cmp")

      if cmp_loaded then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")

        cmp.event:on(
          "confirm_done",
          cmp_autopairs.on_confirm_done({
            map_char = { tex = "" },
          })
        )
      end
    end,
  },
}
