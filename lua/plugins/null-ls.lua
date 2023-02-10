return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
    },
    config = function()
      local null_ls = require("null-ls")

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
      null_ls.setup({
        on_attach = require("config.lsp-config").on_attach,
        capabilities = require("config.lsp-config").capabilities,
        sources = {
          -- Check the spelling
          null_ls.builtins.code_actions.cspell.with({
            filetypes = { "astro", "css", "html", "javascript", "json", "jsx", "php", "svelte", "terraform", "tsx", "typescript" },
            extra_args = spellingConfig,
          }),
          null_ls.builtins.diagnostics.cspell.with({
            filetypes = { "astro", "css", "html", "javascript", "json", "jsx", "php", "svelte", "terraform", "tsx", "typescript" },
            extra_args = spellingConfig,
            diagnostic_config = diagnosticConfig,
            diagnostics_postprocess = infoSeverity,
          }),

          -- Grammar checker
          null_ls.builtins.code_actions.ltrs.with({
            filetypes = ltrsFieTypes,
          }),
          null_ls.builtins.diagnostics.ltrs.with({
            filetypes = ltrsFieTypes,
            diagnostic_config = diagnosticConfig,
            diagnostics_postprocess = infoSeverity,
          }),

          -- PHP
          null_ls.builtins.diagnostics.phpstan,

          -- Nix
          null_ls.builtins.formatting.nixfmt, -- Opinionated formatter
          null_ls.builtins.diagnostics.deadnix,
          null_ls.builtins.diagnostics.statix,
          null_ls.builtins.code_actions.statix,
        },
      })
    end
  },

  -- Null-ls mason integration / translation
  {
    "jay-babu/mason-null-ls.nvim",
    cmd = { "NullInstall", "NullUninstall" },
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" }
    },
    opts = {
      automatic_installation = false,
      automatic_setup = false,
    },
    config = function(_, opts)
      require("mason-null-ls").setup(opts)
    end
  },
}
