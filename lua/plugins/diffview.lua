-- Nice diff view for staging, as well as pull requests
return {
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
  },
}
