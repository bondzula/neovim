return {
  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gs = require("gitsigns")

      gs.setup({
        on_attach = function(bufNum)
          -- Navigation
          vim.keymap.set("n", "]c", gs.next_hunk, { desc = "Next Hunk", buffer = bufNum })
          vim.keymap.set("n", "[c", gs.prev_hunk, { desc = "Previous Hunk", buffer = bufNum })

          -- Actions
          vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { desc = "Stage Hunk", buffer = bufNum })
          vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk", buffer = bufNum })
          vim.keymap.set("n", "<leader>gS", gs.stage_buffer, { desc = "Stage Buffer", buffer = bufNum })
          vim.keymap.set(
            "n",
            "<leader>gu",
            gs.undo_stage_hunk,
            { desc = "Reset Staged Hunk", buffer = bufNum }
          )
          vim.keymap.set(
            "n",
            "<leader>gR",
            gs.reset_buffer,
            { desc = "Reset Staged Buffer", buffer = bufNum }
          )
          vim.keymap.set("n", "<leader>gk", gs.preview_hunk, { desc = "Preview Hunk", buffer = bufNum })
          vim.keymap.set(
            "n",
            "<leader>gb",
            gs.toggle_current_line_blame,
            { desc = "Toggle line blame", buffer = bufNum }
          )

          -- Text object
          vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")

          -- Visual mode staging
          vim.keymap.set("v", "<leader>gs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end)
          vim.keymap.set("v", "<leader>gr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end)
        end,
      })
    end,
  },

  -- Octo
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    keys = {
      { "<leader>is", "<cmd>Octo issue list<cr>", desc = "Issue Search" },
      { "<leader>in", "<cmd>Octo issue create<cr>", desc = "New Issue" },
      { "<leader>gpl", "<cmd>Octo pr list<cr>", desc = "List Pull Requests" },
    },
    opts = {
      mappings = {
        issue = {
          reload = { lhs = "<C-r>", desc = "Reload Issue" },
          copy_url = { lhs = "<C-y>", desc = "Copy URL" },
          list_issues = { lhs = "<space>is", desc = "Issue Search" },
          close_issue = { lhs = "<space>ic", desc = "Close Issue" },
          reopen_issue = { lhs = "<space>io", desc = "Reopen Issue" },
          add_assignee = { lhs = "<space>iaa", desc = "Add Assignee" },
          remove_assignee = { lhs = "<space>ida", desc = "Remove Assignee" },
          add_label = { lhs = "<space>ial", desc = "Add Label" },
          remove_label = { lhs = "<space>idl", desc = "Remove Label" },
          goto_issue = { lhs = "<space>ig", desc = "navigate to a local repo issue" },
          add_comment = { lhs = "<space>iac", desc = "Add Comment" },
          delete_comment = { lhs = "<space>idc", desc = "Delete Comment" },
        },
      },
    },
    config = function(_, opts)
      require("octo").setup(opts)
    end,
  },

  -- Diffview
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    },
    opts = {
      view = {
        -- For more info, see ':h diffview-config-view.x.layout'.
        default = {
          layout = "diff2_horizontal",
          winbar_info = false,
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
          winbar_info = true,
        },

        file_history = {
          layout = "diff2_horizontal",
          winbar_info = false,
        },
      },
    },
    config = function(_, opts)
      require("diffview").setup(opts)
    end,
  },

  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" },
    },
    opts = {
      disable_hint = true,
      disable_commit_confirmation = true,
      -- Change the default way of opening neogit
      kind = "replace",
      -- Change the default way of opening the commit popup
      commit_popup = {
        kind = "split",
      },

      -- Change the default way of opening popups
      popup = {
        kind = "split",
      },
      -- customize displayed signs
      signs = {
        -- { CLOSED, OPENED }
        section = { ">", "v" },
        item = { ">", "v" },
        hunk = { "", "" },
      },
      integrations = {
        diffview = true,
      },
    },
    config = function(_, opts)
      require("neogit").setup(opts)
    end,
  },
}
