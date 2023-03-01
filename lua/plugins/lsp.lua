local on_attach = require("config.lsp-config").on_attach
local capabilities = require("config.lsp-config").capabilities

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
      for _, lsp in pairs(require('util.lists').lsp_servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      -- Lua
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.stdpath "config" .. "/lua"] = true,
              },
            },
            format = {
              enable = true,
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
                max_line_length = "unset",
              }
            },
            telemetry = {
              enable = false,
            },
          }
        }
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
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      ensure_installed = require('util.lists').lsp_servers,
    },
  },
}
