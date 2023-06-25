return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      --
      -- file types for language tool
      local ltrsFieTypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text", "NeogitCommitMessage", "octo" }

      opts.sources = vim.list_extend(opts.sources, {
        -- Grammar checker
        nls.builtins.code_actions.ltrs.with({
          filetypes = ltrsFieTypes,
        }),
        nls.builtins.diagnostics.ltrs.with({
          filetypes = ltrsFieTypes,
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity["INFO"]
          end,
        }),

        -- PHP
        nls.builtins.diagnostics.phpstan,

        -- Nix
        nls.builtins.formatting.nixfmt, -- Opinionated formatter
        nls.builtins.diagnostics.deadnix,
        nls.builtins.diagnostics.statix,
        nls.builtins.code_actions.statix,

        -- go
        nls.builtins.formatting.gofumpt,
        nls.builtins.formatting.goimports_reviser,
        nls.builtins.formatting.golines,
      })
    end,
  },
}
