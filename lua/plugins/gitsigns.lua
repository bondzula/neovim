-- Nice gutter signt, plus buffer commands for working with changes
return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gs = require("gitsigns")

      gs.setup({
        on_attach = function(bufNum)
          local map = vim.keymap.set
          -- Navigation
          map("n", "]c", gs.next_hunk, { desc = "Next Hunk", buffer = bufNum })
          map("n", "[c", gs.prev_hunk, { desc = "Previous Hunk", buffer = bufNum })

          -- Actions
          map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage Hunk", buffer = bufNum })
          map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk", buffer = bufNum })
          map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage Buffer", buffer = bufNum })
          map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Reset Staged Hunk", buffer = bufNum })
          map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset Staged Buffer", buffer = bufNum })
          map("n", "<leader>gk", gs.preview_hunk, { desc = "Preview Hunk", buffer = bufNum })
          map("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Toggle line blame", buffer = bufNum })

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")

          -- Visual mode staging
          map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
          map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
        end,
      })
    end,
  },
}
