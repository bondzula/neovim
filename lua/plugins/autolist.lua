return {
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
}
