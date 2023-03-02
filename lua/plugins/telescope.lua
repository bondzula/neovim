return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "natecraddock/telescope-zf-native.nvim" },
    },
    keys = {
      { "<C-p>",      "<cmd>Telescope find_files<cr>",                    desc = "Find Files (root dir)" },
      { "<leader>,",  "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>/",  "<cmd>Telescope live_grep<cr>",                     desc = "Diagnostics" },
      { "<leader>bb", "<cmd>Telescope buffers<cr>",                       desc = "Buffers" },
      -- search
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>",     desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>",               desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>",                      desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics<cr>",                   desc = "Diagnostics" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>",                     desc = "Diagnostics" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>",                     desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>",                    desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>",                       desc = "Key Maps" },
      { "<leader>sm", "<cmd>Telescope marks<cr>",                         desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>",                   desc = "Options" },
    },
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim", -- Don't show weird indented lines
        },
        layout_config = {
          preview_width = 0.6,
          prompt_position = "top",
        },
        path_display = { "smart" },
        prompt_position = "top",
        prompt_prefix = " ",
        selection_caret = " ",
        sorting_strategy = "ascending",
      },
      pickers = {
        buffers = {
          prompt_prefix = "﬘ ",
        },
        commands = {
          prompt_prefix = " ",
        },
        git_files = {
          prompt_prefix = " ",
          show_untracked = true,
        },
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")

      telescope.setup(opts)
      telescope.load_extension("zf-native")
    end,
  },
}
