return {
  {
    'neovim/nvim-lspconfig',
    event = "BufReadPre",
    dependencies = {
      { "folke/neodev.nvim", config = true },

      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "glepnir/lspsaga.nvim" },
      { "ray-x/lsp_signature.nvim" },
      { "jose-elias-alvarez/null-ls.nvim" },
      { "jay-babu/mason-null-ls.nvim" },
    },
    config = function()
      local lspconfig = require('lspconfig')
      local cmp_nvim_lsp = require('cmp_nvim_lsp')

      local servers = {
        "ansiblels",
        "astro",
        "bashls",
        "cssls",
        "dockerls",
        "emmet_ls",
        "gopls",
        "html",
        "jsonls",
        "tsserver",
        "rnix",
        "intelephense",
        "rust_analyzer",
        "sqls",
        "pyright",
        "tailwindcss",
        "terraformls",
        "volar",
      }

      local customServers = {
        "sumneko_lua",
      }

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_extend("force", servers, customServers),
        automatic_installation = true
      })

      require("lspsaga").setup({
        symbol_in_winbar = {
          enable = false,
        },
        ui = {
          -- Currently, only the round theme exists
          theme = "round",
          -- This option only works in Neovim 0.9
          title = true,
          -- Border type can be single, double, rounded, solid, shadow.
          border = "rounded",
          winblend = 0,
          expand = "",
          collapse = "",
          preview = " ",
          code_action = "💡",
          diagnostic = "🐞",
          incoming = " ",
          outgoing = " ",
          hover = ' ',
          colors = require("catppuccin.groups.integrations.lsp_saga").custom_colors(),
          kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
        },
      })

      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- JavaScript
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.code_actions.eslint_d,

          null_ls.builtins.formatting.prettierd,

          -- Check the spelling
          null_ls.builtins.diagnostics.cspell,
          null_ls.builtins.code_actions.cspell,

          -- CSS
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.stylua,

          -- PHP
          null_ls.builtins.diagnostics.phpstan,

          -- Git commit
          null_ls.builtins.diagnostics.commitlint,
        },
      })

      require("mason-null-ls").setup({
        ensure_installed = nil,
        automatic_installation = true,
        automatic_setup = false,
      })

      -- TODO: autocmd for signature_help on CursorHoldI
      local on_attach = function(_, bufferNum)
        -- configure omnifunc
        vim.api.nvim_buf_set_option(bufferNum, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufferNum, desc = "Go to Definition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufferNum, desc = "Go to Declaration" })
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = bufferNum, desc = "Go to Type Definition"  })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufferNum, desc = "Go to Implementation" })

        -- Rename
        vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<cr>", { buffer = bufferNum, desc = "Rename"})
        vim.keymap.set("n", "gR", "<cmd>Lspsaga rename ++project<cr>", { buffer = bufferNum, desc = "Rename in Project"})

        -- Help
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", { buffer = bufferNum, desc = "Show Help" })

        -- Diagnostics
        vim.keymap.set("n", "ga", "<cmd>Lspsaga code_action<cr>", { buffer = bufferNum, desc = "Show Code Actions" })
        vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { buffer = bufferNum, desc = "Go to Next Error" })
        vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { buffer = bufferNum, desc = "Go to Prev Error" })

        -- Code
        vim.keymap.set("n", "<leader>cp", "<cmd>Lspsaga peek_definition<cr>", { buffer = bufferNum, desc = "Peek Definition"})
        vim.keymap.set("n", "<leader>co", "<cmd>Lspsaga outline<cr>", { buffer = bufferNum, desc = "Open Outline"})
        vim.keymap.set("n", "<leader>cf", "<cmd>Lspsaga lsp_finder<CR>", { buffer = bufferNum, desc = "LSP Finder"})
        vim.keymap.set("n", "<leader>cr", "<cmd>Telescope lsp_references<cr>", { buffer = bufferNum, desc = "Show References"})
        vim.keymap.set("n", "<leader>cs", "<cmd>Telescope lsp_document_symbols<cr>", { buffer = bufferNum, desc = "Show Document Symbols"})
        vim.keymap.set("n", "<leader>cS", "<cmd>Telescope lsp_workspace_symbols<cr>", { buffer = bufferNum, desc = "Show Workspace Symbols"})

        -- Trouble
        vim.keymap.set("n", "<leader>cd", "<cmd>Trouble document_diagnostics<cr>", { buffer = bufferNum, desc = "Open Document Diagnostics"})
        vim.keymap.set("n", "<leader>cD", "<cmd>Trouble workspace_diagnostics<cr>", { buffer = bufferNum, desc = "Open Workspace Diagnostics"})

        -- General tools
        vim.keymap.set("n", "<leader>cm", "<cmd>Mason<cr>", { buffer = bufferNum, desc = "Mason"})
        vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { buffer = bufferNum, desc = "Lsp Info"})

        -- Signature help
        require "lsp_signature".on_attach({
          hint_enable = false,
          handler_opts = { border = "single" },
          max_width = 80,
        }, bufferNum)
      end

      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }

      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
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

      -- Setup server capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

      -- Enable snippets
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- General server config
      for _, lsp in pairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          flags = lsp_flags
        })
      end

      -- Custom server setup

      -- Lua
      lspconfig.sumneko_lua.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim', 'print', 'require' },
            },
          },
        },
      }
    end
  },

}
