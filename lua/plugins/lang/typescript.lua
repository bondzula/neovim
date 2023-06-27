return {
  -- add typescript to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "tsx",
          "typescript",
        })
      end
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "eslint_d",
        "prettierd",
      })
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      opts.sources = vim.list_extend(opts.sources, {
        require("null-ls").builtins.formatting.prettierd,
        require("null-ls").builtins.diagnostics.eslint_d,
        require("null-ls").builtins.code_actions.eslint_d,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "jose-elias-alvarez/typescript.nvim" },
    opts = {
      -- make sure mason installs the server
      servers = {
        ---@type lspconfig.options.tsserver
        tsserver = {
          settings = {
            typescript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
            },
            javascript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
            },
            completions = {
              completeFunctionCalls = true,
            },
          },
        },
      },
      setup = {
        tsserver = function(_, opts)
          require("lazyvim.util").on_attach(function(client, buffer)
            if client.name == "tsserver" then
              -- stylua: ignore
              vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
              -- stylua: ignore
              vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
            end
          end)
          require("typescript").setup({ server = opts })
          return true
        end,
      },
    },
  },
}
