-- Task runner
return {
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
            return not vim.tbl_isempty(vim.fs.find("artisan", {}))
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
}
