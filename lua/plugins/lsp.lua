local on_attach = require("config.lsp-config").on_attach
local capabilities = require("config.lsp-config").capabilities

-- Servers with default config
local servers = {
  "ansiblels", "astro", "bashls", "cssls", "dockerls", "emmet_ls", "eslint", "gopls", "html", "jsonls",
  "tsserver", "rnix", "intelephense", "rust_analyzer", "sqls", "pyright", "tailwindcss", "terraformls", "volar",
}

-- General LSP settings
-- Diagnostics config (disable virtual text, and sort by serverity)
vim.diagnostic.config({
  signs = true,
  underline = true,
  virtual_text = false,
  severity_sort = true,
  update_in_insert = false,
})

-- Add icons for each diagnostic type
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

return {
  { "gpanders/editorconfig.nvim" },

  {
    "folke/neodev.nvim",
    ft = { "lua" },
    config = function()
      require("neodev").setup()
    end
  },

  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "folke/neodev.nvim" },
    },
    config = function()
      local lspconfig = require("lspconfig")

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
            format = {
              enable = true,
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
    cmd = "Mason",
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
