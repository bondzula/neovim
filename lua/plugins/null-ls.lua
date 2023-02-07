local on_attach = require("config.lsp-config").on_attach
local capabilities = require("config.lsp-config").capabilities

return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
    },
    config = function()
      local null_ls = require('null-ls')

      -- Get the dictionary
      local spellingConfig = { extra_args = { "--config", vim.fn.expand("~/.config/nvim/cspell.json") } }

      local ltrsSettings = {
        filetypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text", "NeogitCommitMessage", "octo" },
      }

      null_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        sources = {
          -- Check the spelling
          null_ls.builtins.diagnostics.cspell.with({
            extra_args = { "--config", spellingConfig },
            diagnostic_config = {
              underline = true,
              virtual_text = false,
              signs = true,
              update_in_insert = false,
              severity_sort = true,
            },
            diagnostics_postprocess = function(diagnostic)
              diagnostic.severity = vim.diagnostic.severity["INFO"]
            end,
          }),
          null_ls.builtins.code_actions.cspell.with({
            extra_args = { "--config", spellingConfig },
          }),

          -- PHP
          null_ls.builtins.diagnostics.phpstan,

          -- Grammar checker
          null_ls.builtins.diagnostics.ltrs.with(ltrsSettings),
          null_ls.builtins.code_actions.ltrs.with(ltrsSettings),
        },
      })
    end
  },

  -- Null-ls mason integration / translation
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" }
    },
    opts = {
      automatic_installation = true,
      automatic_setup = false,
    },
    config = function(_, opts)
      require("mason-null-ls").setup(opts)
    end
  },
}
