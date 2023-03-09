-- Description: Completion plugins
return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "hrsh7th/cmp-path" },

      { "saadparwaiz1/cmp_luasnip" },
      { "onsails/lspkind-nvim" },
      { "petertriho/cmp-git" },
    },
    opts = function()
      local cmp = require("cmp")

      return {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          -- Navigate through completion menu
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          -- Scroll docs for the currently selected item
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          -- Close completion menu
          ["<C-e>"] = cmp.mapping.abort(),
          -- Confirm Completion
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        },
        formatting = {
          format = require("lspkind").cmp_format(),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip" },
          { name = "git" },
          { name = "path" },
          { name = "nvim_lua" },
        },
        view = {
          entries = "native",
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered()
        },
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")

      cmp.setup(opts)

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(), -- Tab for selection (arrows needed for selecting past items)
        sources = { { name = "buffer" } },
        view = {
          entries = "custom",
        },
      })

      cmp.setup.cmdline({ ":" }, {
        mapping = cmp.mapping.preset.cmdline(), -- Tab for selection (arrows needed for selecting past items)
        sources = {
          { name = "cmdline" },
          { name = "path" }
        },
        view = {
          entries = "custom",
        },
      })
    end,
  },

  -- GitHub completion
  {
    "petertriho/cmp-git",
    ft = { "gitcommit", "octo", "NeogitCommitMessage" },
    dependencies = {
      { "nvim-lua/plenary.nvim" }
    },
    opts = {
      filetypes = { "gitcommit", "octo", "NeogitCommitMessage" },
    }
  },
}
