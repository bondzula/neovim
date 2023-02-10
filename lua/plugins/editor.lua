return {
  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      -- Install plenary
      { "nvim-lua/plenary.nvim" },

      -- Add lib with more accurate filename matching using the zf algorithm
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
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          theme = "dropdown",
          winblend = 10,
          width = 0.5,
          prompt = " ",
          results_height = 18,
          previewer = false,
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")

      telescope.setup(opts)
      telescope.load_extension("zf-native")
    end,
  },

  -- Treesitter for batter highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "windwp/nvim-ts-autotag" },
    },
    build = ":TSUpdate",
    event = "BufReadPost",
    opts = {
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      ensure_installed = require('util.lists').treesitter_parsers,
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-Space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
      autotag = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- Autopairs
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

  -- Batter folding
  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    opts = {
      close_fold_kinds = { "imports", "comment" },
      preview = {
        win_config = {
          border = { "", "─", "", "", "", "─", "", "" },
          winhighlight = "Normal:Folded",
          winblend = 0,
        },
        mappings = {
          scrollU = "<C-u>",
          scrollD = "<C-d>",
        },
      },
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    },
    config = function(_, opts)
      require("ufo").setup(opts)

      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open All Folds" })
      vim.keymap.set("n", "zm", require("ufo").closeAllFolds, { desc = "Close All Folds" })
      vim.keymap.set("n", "zK", require("ufo").peekFoldedLinesUnderCursor, { desc = "Peek folds" })

      vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable = true
    end,
  },

  -- Word Highlighting
  {
    "echasnovski/mini.cursorword",
    event = "CursorHold",
    opts = {
      delay = 600,
    },
    config = function(_, opts)
      require("mini.cursorword").setup(opts)

      vim.api.nvim_set_hl(0, "MiniCursorword", { link = "Visual" })
    end,
  },

  -- Buffer remove
  {
    "echasnovski/mini.bufremove",
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)" },
    },
  },

  -- Which key
  {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")

      wk.setup()
      wk.register({
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gz"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>r"] = { name = "+refactor" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>i"] = { name = "+issues" },
        -- ["<leader>gp"] = { name = "+prs" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>sn"] = { name = "+noice" },
        -- TODO: this is not correct, check the LazyVim
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      })
    end,
  },

  -- Better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    },
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = true,
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                         desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                       desc = "Todo" },
    },
  },

  -- Figure out where does this belong to?
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
    config = function()
      require('flit').setup {
        keys = { f = 'f', F = 'F', t = 't', T = 'T' },
        -- A string like "nv", "nvo", "o", etc.
        labeled_modes = "v",
        multiline = false,
      }
    end
  },

  -- Get all fency doing things without even moving
  {
    "ggandor/leap-spooky.nvim",
    config = function()
      require('leap-spooky').setup {
        affixes = {
          remote   = { window = 'r', cross_window = 'R' },
          magnetic = { window = 'm', cross_window = 'M' },
        },
        -- If this option is set to true, the yanked text will automatically be pasted
        -- at the cursor position if the unnamed register is in use.
        paste_on_remote_yank = false,
      }
    end
  },

  -- Regex explainer
  {
    "bennypowers/nvim-regexplainer",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
      { "MunifTanjim/nui.nvim" },
    },
    keys = {
      { '<leader>ce', function() require('regexplainer').toggle() end, desc = "Regexp explainer toggle" }
    },
    opts = {
      mode = "narrative",
      auto = false,
      filetypes = { "html", "js", "cjs", "mjs", "ts", "jsx", "tsx", "cjsx", "mjsx", "vue" },
      debug = false,
      display = "popup",
      popup = {
        border = {
          padding = { 1, 2 },
          style = 'solid',
        },
      },
      narrative = {
        separator = "\n",
      },
    },
    config = function(_, opts)
      require "regexplainer".setup(opts)
    end,
  },

  -- Auto list for markdown based files / buffers
  {
    "gaoDean/autolist.nvim",
    ft = { "markdown", "text", "tex", "plaintex", "octo", "gitcommit", "NeogitCommitMessage" },
    event = "BufReadPost",
    config = function()
      local autolist = require("autolist")
      autolist.setup()
      autolist.create_mapping_hook("i", "<CR>", autolist.new)
      autolist.create_mapping_hook("i", "<Tab>", autolist.indent)
      autolist.create_mapping_hook("i", "<S-Tab>", autolist.indent, "<C-D>")
      autolist.create_mapping_hook("n", "o", autolist.new)
      autolist.create_mapping_hook("n", "O", autolist.new_before)
      autolist.create_mapping_hook("n", ">>", autolist.indent)
      autolist.create_mapping_hook("n", "<<", autolist.indent)
      vim.api.nvim_create_autocmd("TextChanged", {
        pattern = "*",
        callback = function()
          vim.cmd.normal({ autolist.force_recalculate(nil, nil), bang = false })
        end
      })
    end,
  },

  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
  },
}
