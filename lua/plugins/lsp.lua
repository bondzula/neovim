return {
  {
    "neovim/nvim-lspconfig",
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
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local servers = {
        "ansiblels",
        "astro",
        "bashls",
        "cssls",
        "dockerls",
        "emmet_ls",
        "eslint",
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

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
      })

      require("lspsaga").setup({
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
      })

      local on_attach = function(_, bufferNum)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufferNum, desc = "Go to Definition" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufferNum, desc = "Go to Declaration" })
        vim.keymap.set(
          "n",
          "gT",
          vim.lsp.buf.type_definition,
          { buffer = bufferNum, desc = "Go to Type Definition" }
        )
        vim.keymap.set(
          "n",
          "gi",
          vim.lsp.buf.implementation,
          { buffer = bufferNum, desc = "Go to Implementation" }
        )

        -- Rename
        vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<cr>", { buffer = bufferNum, desc = "Rename" })
        vim.keymap.set(
          "n",
          "gR",
          "<cmd>Lspsaga rename ++project<cr>",
          { buffer = bufferNum, desc = "Rename in Project" }
        )

        -- Help
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", { buffer = bufferNum, desc = "Show Help" })

        -- Diagnostics
        vim.keymap.set(
          "n",
          "ga",
          "<cmd>Lspsaga code_action<cr>",
          { buffer = bufferNum, desc = "Show Code Actions" }
        )
        vim.keymap.set(
          "n",
          "]e",
          "<cmd>Lspsaga diagnostic_jump_next<CR>",
          { buffer = bufferNum, desc = "Go to Next Error" }
        )
        vim.keymap.set(
          "n",
          "[e",
          "<cmd>Lspsaga diagnostic_jump_prev<CR>",
          { buffer = bufferNum, desc = "Go to Prev Error" }
        )

        -- Code
        vim.keymap.set(
          "n",
          "<leader>cp",
          "<cmd>Lspsaga peek_definition<cr>",
          { buffer = bufferNum, desc = "Peek Definition" }
        )
        vim.keymap.set(
          "n",
          "<leader>co",
          "<cmd>Lspsaga outline<cr>",
          { buffer = bufferNum, desc = "Open Outline" }
        )
        vim.keymap.set(
          "n",
          "<leader>cf",
          "<cmd>Lspsaga lsp_finder<CR>",
          { buffer = bufferNum, desc = "LSP Finder" }
        )
        vim.keymap.set(
          "n",
          "<leader>cr",
          "<cmd>Telescope lsp_references<cr>",
          { buffer = bufferNum, desc = "Show References" }
        )
        vim.keymap.set(
          "n",
          "<leader>cs",
          "<cmd>Telescope lsp_document_symbols<cr>",
          { buffer = bufferNum, desc = "Show Document Symbols" }
        )
        vim.keymap.set(
          "n",
          "<leader>cS",
          "<cmd>Telescope lsp_workspace_symbols<cr>",
          { buffer = bufferNum, desc = "Show Workspace Symbols" }
        )

        -- Trouble
        vim.keymap.set(
          "n",
          "<leader>cd",
          "<cmd>Trouble document_diagnostics<cr>",
          { buffer = bufferNum, desc = "Open Document Diagnostics" }
        )
        vim.keymap.set(
          "n",
          "<leader>cD",
          "<cmd>Trouble workspace_diagnostics<cr>",
          { buffer = bufferNum, desc = "Open Workspace Diagnostics" }
        )

        -- General tools
        vim.keymap.set("n", "<leader>cm", "<cmd>Mason<cr>", { buffer = bufferNum, desc = "Mason" })
        vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { buffer = bufferNum, desc = "Lsp Info" })

        -- Signature help
        require("lsp_signature").on_attach({
          hint_enable = false,
          handler_opts = { border = "single" },
          max_width = 80,
        }, bufferNum)
      end

      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }

      local null_ls = require("null-ls")

      local spellingConfig = { extra_args = { "--config", vim.fn.expand("~/.config/nvim/cspell.json") } }

      null_ls.setup({
        on_attach = on_attach,
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
        },
      })

      require("mason-null-ls").setup({
        ensure_installed = nil,
        automatic_installation = true,
        automatic_setup = false,
      })

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
          flags = lsp_flags,
        })
      end

      -- Lua
      lspconfig.sumneko_lua.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
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

      -- LanguageTool spell checking
      lspconfig.ltex.setup({
        filetypes = {
          "bib",
          "gitcommit",
          "markdown",
          "org",
          "plaintex",
          "rst",
          "rnoweb",
          "tex",
          "pandoc",
          "NeogitCommitMessage",
          "octo",
        },
        settings = {
          ltex = {
            language = "en-US",
            additionalRules = {
              enablePickyRules = true,
              -- languageModel = "$XDG_DATA_HOME/ngrams/",
            },
            -- dictionary = {
            --   ["en-US"] = readFiles(dictionary_file['en-US'] or {})
            -- },
            -- disabledRules = {
            --   ["en-US"] = readFiles(disabled_rules_file['en-US'] or {})
            -- },
            -- hiddenFalsePositives = {
            --   ["en-US"] = readFiles(false_positives_file['en-US'] or {})
            -- },
          },
        },
      })
    end,
  },
}
