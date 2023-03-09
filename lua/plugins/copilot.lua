-- Description: Autocomplete plugin for nvim-cmp
return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    keys = {
      { "<M-]>", function() require("copilot.suggestion").next() end,        mode = "i", desc = "Copilot Next" },
      { "<M-[>", function() require("copilot.suggestion").prev() end,        mode = "i", desc = "Copilot Previous" },
      { "<M-.>", function() require("copilot.suggestion").accept() end,      mode = "i", desc = "Copilot Accept" },
      { "<M->>", function() require("copilot.suggestion").accept_line() end, mode = "i", desc = "Copilot Accept Line" },
    },
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = false,
        debounce = 75,
        keymap = {
          accept = false,
          accept_word = false,
          accept_line = false,
          dismiss = false,
          next = false,
        },
      },
    },
  },
}
