return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "ansible-language-server",
        "astro-language-server",
        "bash-language-server",
        "css-lsp",
        "dockerfile-language-server",
        "emmet-ls",
        "gopls",
        "html-lsp",
        "intelephense",
        "lua-language-server",
        "marksman",
        "nil",
        "prisma-language-server",
        "pyright",
        "rust-analyzer",
        "sqlls",
        "stylelint-lsp",
        "svelte-language-server",
        "tailwindcss-language-server",
        "terraform-ls",
        "vue-language-server",
      })
    end,
  },
}
