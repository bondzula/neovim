return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "astro",
        "css",
        "dockerfile",
        "gitcommit",
        "gitignore",
        "git_rebase",
        "go",
        "hcl",
        "kdl",
        "make",
        "nix",
        "php",
        "phpdoc",
        "rust",
        "sql",
        "svelte",
        "toml",
        "vue",
      },
    },
  },
}
