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
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Restore Session",
      },
      {
        "<leader>ql",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore Last Session",
      },
      {
        "<leader>qd",
        function()
          require("persistence").stop()
        end,
        desc = "Don't Save Current Session",
      },
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
    "numToStr/Navigator.nvim",
    keys = {
      { "<C-h>", "<cmd>NavigatorLeft<cr>" },
      { "<C-l>", "<cmd>NavigatorRight<cr>" },
      { "<C-k>", "<cmd>NavigatorUp<cr>" },
      { "<C-j>", "<cmd>NavigatorDown<cr>" },
    },
    config = function()
      require("Navigator").setup({})
    end,
  },

  -- Task runner
  {
    "stevearc/overseer.nvim",
    keys = {
      { "<leader>tt", "<cmd>OverseerToggle[!] right<cr>", desc = "Toggle Task View" },
      { "<leader>tr", "<cmd>OverseerRun<cr>", desc = "Run a task" },
      { "<leader>tR", "<cmd>OverseerRunCmd<cr>", desc = "Run a custom task" },
      { "<leader>ta", "<cmd>OverseerTaskAction<cr>", desc = "Task Actions" },
    },
    config = function()
      require("overseer").setup()

      -- TODO: move into a utility file
      require("overseer").register_template({
        name = "Laravel Artisan Serve",
        params = {},
        condition = {
          callback = function()
            return not vim.tbl_isempty(vim.fs.find("artisan"))
          end,
        },
        builder = function()
          return {
            cmd = { "php" },
            args = { "artisan", "serve" },
          }
        end,
      })
    end,
  },

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
      dir = "", -- directory where `lf` starts ('gwd' is git-working-directory, "" is CWD)
      direction = "float", -- window type: float horizontal vertical
      border = "curved", -- border kind: single double shadow curved
      height = 0.80, -- height of the *floating* window
      width = 0.85, -- width of the *floating* window
      escape_quit = true, -- map escape to the quit command (so it doesn't go into a meta normal mode)
      focus_on_open = false, -- focus the current file when opening Lf (experimental)

      mappings = true, -- whether terminal buffer mapping is enabled
      tmux = false, -- tmux statusline can be disabled on opening of Lf
    },
    config = function(_, opts)
      require("lf").setup(opts)
    end
  },

  -- Snippet runner
  {
    "michaelb/sniprun",
    build = "bash install.sh",
    cmd = "Sniprun",
    config = function()
      require("sniprun").setup({
        selected_interpreters = { "JS_TS_deno" },
        repl_enable = { "JS_TS_deno" },
      })
    end,
  },
}
