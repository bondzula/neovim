return {
  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    config = function(_, opts)
      local gs = require('gitsigns')

      gs.setup({
        on_attach = function(bufnr)
          -- Navigation
          vim.keymap.set('n', ']c', gs.next_hunk, { desc = "Next Hunk", buffer = bufnr })
          vim.keymap.set('n', '[c', gs.prev_hunk, { desc = "Previous Hunk", buffer = bufnr })

          -- Actions
          vim.keymap.set('n', '<leader>gs', gs.stage_hunk, { desc = "Stage Hunk", buffer = bufnr })
          vim.keymap.set('n', '<leader>gr', gs.reset_hunk, { desc = "Reset Hunk", buffer = bufnr })
          vim.keymap.set('n', '<leader>gS', gs.stage_buffer, { desc = "Stage Buffer", buffer = bufnr })
          vim.keymap.set('n', '<leader>gu', gs.undo_stage_hunk, { desc = "Reset Staged Hunk", buffer = bufnr })
          vim.keymap.set('n', '<leader>gR', gs.reset_buffer, { desc = "Reset Staged Buffer", buffer = bufnr })
          vim.keymap.set('n', '<leader>gk', gs.preview_hunk, { desc = "Preview Hunk", buffer = bufnr })
          vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Toggle line blame", buffer = bufnr })

          -- Text object
          vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

          -- Visual mode staging
          vim.keymap.set('v', '<leader>gs', function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
          vim.keymap.set('v', '<leader>gr', function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
        end
      })
    end
  },

  -- Octo
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    config = function()
      require"octo".setup()
    end
  },

  -- Diffview
  {
    "sindrets/diffview.nvim",
    config = function()
      require('diffview').setup({
        view = {
          -- Configure the layout and behavior of different types of views.
          -- Available layouts:
          --  'diff1_plain'
          --    |'diff2_horizontal'
          --    |'diff2_vertical'
          --    |'diff3_horizontal'
          --    |'diff3_vertical'
          --    |'diff3_mixed'
          --    |'diff4_mixed'
          -- For more info, see ':h diffview-config-view.x.layout'.
          default = {
            -- Config for changed files, and staged files in diff views.
            layout = "diff2_horizontal",
            winbar_info = false,          -- See ':h diffview-config-view.x.winbar_info'
          },
          merge_tool = {
            -- Config for conflicted files in diff views during a merge or rebase.
            layout = "diff3_horizontal",
            disable_diagnostics = true,   -- Temporarily disable diagnostics for conflict buffers while in the view.
            winbar_info = true,           -- See ':h diffview-config-view.x.winbar_info'
          },

          file_history = {
            -- Config for changed files in file history views.
            layout = "diff2_horizontal",
            winbar_info = false,          -- See ':h diffview-config-view.x.winbar_info'
          },
        },
      })
    end
  },
}
