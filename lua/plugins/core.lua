return {
  -- measure startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
  
  -- library used by other plugins
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- makes some plugins dot-repeatable like leap
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },

  -- Tmux integration
  {
    'numToStr/Navigator.nvim',
    config = function()
      require('Navigator').setup()

      vim.keymap.set({'n', 't'}, '<C-h>', '<cmd>NavigatorLeft<cr>')
      vim.keymap.set({'n', 't'}, '<C-l>', '<cmd>NavigatorRight<cr>')
      vim.keymap.set({'n', 't'}, '<C-k>', '<cmd>NavigatorUp<cr>')
      vim.keymap.set({'n', 't'}, '<C-j>', '<cmd>NavigatorDown<cr>')
    end
  },

  -- Task runner
  {
    "stevearc/overseer.nvim",
    config = function()
      require('overseer').setup()

      vim.keymap.set('n', '<leader>tt', '<cmd>OverseerToggle[!] right<cr>', { desc = 'Toggle Task View' })
      vim.keymap.set('n', '<leader>tr', '<cmd>OverseerRun<cr>', { desc = 'Run a task' })
      vim.keymap.set('n', '<leader>tR', '<cmd>OverseerRunCmd<cr>', { desc = 'Run a custom task' })
      vim.keymap.set('n', '<leader>ta', '<cmd>OverseerTaskAction<cr>', { desc = 'Task Actions' })

      -- TODO: move into a utlity file
      require("overseer").register_template({
        name = "Laravel Serve: 2",
        params = {},
        condition = {
          callback = function(search)
            return not vim.tbl_isempty(vim.fs.find('artisan'))
          end,
        },
        builder = function()
          return {
            cmd = { "php" },
            args = { "artisan", "serve" },
          }
        end,
      })
    end
  },

  -- Snippet runner
  {
    "michaelb/sniprun",
    build = "bash install.sh",
    config = function()
      require'sniprun'.setup({
        selected_interpreters={"JS_TS_deno"},
        repl_enable={"JS_TS_deno"}
      })
    end
  }
}
