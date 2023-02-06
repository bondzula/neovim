local on_attach = require("config.lsp-config").on_attach
local capabilities = require("config.lsp-config").capabilities

-- Servers with default config
local servers = {
  "ansiblels", "astro", "bashls", "cssls", "dockerls", "emmet_ls", "eslint", "gopls", "html", "jsonls",
  "tsserver", "rnix", "intelephense", "rust_analyzer", "sqls", "pyright", "tailwindcss", "terraformls", "volar",
}

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "folke/neodev.nvim", config = true },
    },
    config = function()
      local lspconfig = require("lspconfig")

      vim.lsp.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
      })

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
        close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
      })

      -- General server config
      for _, lsp in pairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      -- Lua
      lspconfig.sumneko_lua.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "print", "require" },
            },
            -- Use stylua instead
            format = {
              enable = true,
              -- Put format options here

              -- NOTE: the value should be STRING!!
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
                quote_style = "double",
              },
            },
          },
        },
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
    },
    opts = {},
    config = function(_, opts)
      require("mason").setup(opts)
    end
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      automatic_installation = true,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end
  },

  -- Nicer LSP UI
  {
    "glepnir/lspsaga.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      symbol_in_winbar = {
        enable = false,
      },
      lightbulb = {
        enable = false,
      },
      ui = {
        title = true,
        border = "rounded",
      },
    },
    config = function(_, opts)
      require("lspsaga").setup(opts)

    end
  },
}
