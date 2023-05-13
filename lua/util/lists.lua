local M = {}

-- Define the list of LSP servers
M.lsp_servers = {
  "ansiblels",
  "astro",
  "bashls",
  "cssls",
  "dockerls",
  "emmet_ls",
  "eslint",
  "gopls",
  "html",
  "intelephense",
  "jsonls",
  "marksman",
  -- "nil_ls",
  "pyright",
  "rust_analyzer",
  "sqlls",
  "stylelint_lsp",
  "svelte",
  "tailwindcss",
  "terraformls",
  "tsserver",
  "volar",
  "pylsp",
}

-- Define a list of TreeSitter parsers
M.treesitter_parsers = {
  "astro",
  "bash",
  "css",
  "dockerfile",
  "git_rebase",
  "gitcommit",
  "gitignore",
  "go",
  "hcl",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "nix",
  "php",
  "python",
  "query",
  "regex",
  "rust",
  "scss",
  "sql",
  "svelte",
  "terraform",
  "tsx",
  "typescript",
  "vim",
  "vue",
  "yaml",
}

return M
