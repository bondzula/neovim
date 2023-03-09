return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "neovim/nvim-lspconfig" },
    },
    config = function()
      local nls = require("null-ls")

      -- -- Get the dictionary
      local spellingConfig = { "--config", vim.fn.expand("~/.config/nvim/cspell.json") }

      -- Info diagnostic config
      local diagnosticConfig = {
        signs = true,
        underline = true,
        virtual_text = false,
        severity_sort = true,
        update_in_insert = false,
      }

      -- Info severity postprocessing
      local infoSeverity = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity["INFO"]
      end

      -- file types for language tool
      local ltrsFieTypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text", "NeogitCommitMessage", "octo" }

      -- Th is a spelling test for cspell
      nls.setup({
        on_attach = require("config.lsp-config").on_attach,
        capabilities = require("config.lsp-config").capabilities,
        sources = {
          -- Check the spelling
          nls.builtins.code_actions.cspell.with({
            filetypes = {
              "astro",
              "css",
              "html",
              "javascript",
              "json",
              "jsx",
              "php",
              "svelte",
              "terraform",
              "tsx",
              "typescript",
            },
            extra_args = spellingConfig,
          }),
          nls.builtins.diagnostics.cspell.with({
            filetypes = {
              "astro",
              "css",
              "html",
              "javascript",
              "json",
              "jsx",
              "php",
              "svelte",
              "terraform",
              "tsx",
              "typescript",
            },
            extra_args = spellingConfig,
            diagnostic_config = diagnosticConfig,
            diagnostics_postprocess = infoSeverity,
          }),

          -- Grammar checker
          nls.builtins.code_actions.ltrs.with({
            filetypes = ltrsFieTypes,
          }),
          nls.builtins.diagnostics.ltrs.with({
            filetypes = ltrsFieTypes,
            diagnostic_config = diagnosticConfig,
            diagnostics_postprocess = infoSeverity,
          }),

          -- PHP
          nls.builtins.diagnostics.phpstan,

          -- Nix
          nls.builtins.formatting.nixfmt, -- Opinionated formatter
          nls.builtins.diagnostics.deadnix,
          nls.builtins.diagnostics.statix,
          nls.builtins.code_actions.statix,
        },
      })
    end
  },
}
