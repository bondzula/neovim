-- Octo.nvim - GitHub CLI for Neovim
return {
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    keys = {
      { "<leader>is",  "<cmd>Octo issue list<cr>",   desc = "Issue Search" },
      { "<leader>in",  "<cmd>Octo issue create<cr>", desc = "New Issue" },
      { "<leader>gpl", "<cmd>Octo pr list<cr>",      desc = "List Pull Requests" },
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
  },
}
