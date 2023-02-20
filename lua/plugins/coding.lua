return {
  -- Commenting plugin
  {
    "numToStr/Comment.nvim",
    keys = { { "gc" }, { "gb" }, { "gc", mode = "v" }, { "gb", mode = "v" } },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {
      pre_hook = function(ctx)
        -- Only calculate commentstring for tsx filetypes
        if vim.bo.filetype == "typescriptreact" then
          local U = require("Comment.utils")

          -- Determine whether to use linewise or blockwise commentstring
          ---@diagnostic disable-next-line: undefined-field
          local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"

          -- Determine the location where to calculate commentstring from
          local location = nil
          ---@diagnostic disable-next-line: undefined-field
          if ctx.ctype == U.ctype.block then
            location = require("ts_context_commentstring.utils").get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require("ts_context_commentstring.utils").get_visual_start_location()
          end

          return require("ts_context_commentstring.internal").calculate_commentstring({
              key = type,
              location = location,
            })
        end
      end,
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    keys = { { "ds" }, { "cs" }, { "ys" } },
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Generate the docs
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = { "Neogen" },
    keys = {
      { "<leader>cg", function() require('neogen').generate({}) end, desc = "Generate Docs" },
    },
    config = true,
  },

  -- Batter split / join functionality
  {
    "AndrewRadev/splitjoin.vim",
    keys = { { "gJ" }, { "gS" } },
    event = "BufReadPost",
  },

  -- Refactoring helpers
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    keys = {
      -- Remaps for the refactoring operations currently offered by the plugin
      { "<leader>re", "<cmd>lua require('refactoring').refactor('Extract Function')<cr>",         mode = "v",                    desc = "Extract Function" },
      { "<leader>rE", "<cmd>lua require('refactoring').refactor('Extract Function To File')<cr>", mode = "v",                    desc = "Extract Function to File" },
      { "<leader>rv", "<cmd>lua require('refactoring').refactor('Extract Variable')<cr>",         mode = "v",                    desc = "Extract Variable" },
      { "<leader>ri", "<cmd>lua require('refactoring').refactor('Inline Variable')<cr>",          mode = "v",                    desc = "Inline Variable" },
      { "<leader>rb", "<cmd>lua require('refactoring').refactor('Extract Block')<cr>",            desc = "Extract Block" },
      { "<leader>rB", "<cmd>lua require('refactoring').refactor('Extract Block To File')<cr>",    desc = "Extract Block To File" },
    },
    config = function()
      require("refactoring").setup({})
    end,
  },
}
